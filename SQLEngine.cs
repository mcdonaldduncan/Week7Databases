using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using static Week7Databases.Constants;
using System.Data;

namespace Week7Databases
{
    internal class SQLEngine
    {
        string SqlConString { get; set; }
        string TableName { get; set; }
        string ChildTableName { get; set; }
        MyFile CurrentFile { get; set; }

        public SQLEngine(string tableName, string childTableName, MyFile file)
        {
            TableName = tableName;
            ChildTableName = childTableName;
            CurrentFile = file;

            // sourced from powerpoint example
            SqlConnectionStringBuilder sqlConStringBuilder = new SqlConnectionStringBuilder();
            sqlConStringBuilder["server"] = @"(localdb)\MSSQLLocalDB";
            sqlConStringBuilder["Trusted_Connection"] = true;
            sqlConStringBuilder["Integrated Security"] = "SSPI";
            sqlConStringBuilder["Initial Catalog"] = "PROG260FA22";

            SqlConString = sqlConStringBuilder.ToString();

        }

        /// <summary>
        /// Run all necessary sql tasks sequentially
        /// </summary>
        /// <returns></returns>
        public List<Error> RunSqlTasks()
        {
            List<Error> errors = new List<Error>();
            errors.AddRange(Insert());
            errors.AddRange(FullReport());
            errors.AddRange(FindMaplessCharacters());
            errors.AddRange(FindSwordNonHuman());
            errors.AddRange(BinaryCharacterInfo());
            return errors;
        }

        /// <summary>
        /// Read CSV file and insert all data into tables
        /// </summary>
        /// <returns></returns>
        private List<Error> Insert()
        {
            List<Error> errors = new List<Error>();
            List<string[]> lines = new List<string[]>();
            List<string> types = new List<string>();
            List<string> map_locations = new List<string>();

            try
            {
                using (StreamReader sr = new StreamReader(CurrentFile.FilePath))
                {
                    int index = 0;
                    while (!sr.EndOfStream)
                    {
                        if (index == 0)
                        {
                            var headerItems = sr.ReadLine()?.Split(CurrentFile.Delimiter) ?? new string[0];
                        }
                        else
                        {
                            var lineItems = sr.ReadLine()?.Split(CurrentFile.Delimiter) ?? new string[0];

                            for (int i = 0; i < lineItems.Length; i++)
                            {
                                lineItems[i] = lineItems[i].Trim();

                                if (lineItems[i].Contains("'"))
                                {
                                    lineItems[i] = lineItems[i].Replace(lineItems[i].Substring(lineItems[i].IndexOf(@"'")), @"''s ship");
                                }
                            }

                            // Get all unique types
                            if (!types.Contains(lineItems[1]) && lineItems[1] != string.Empty)
                            {
                                types.Add(lineItems[1]);
                            }

                            // Get all unique map locations
                            if (!map_locations.Contains(lineItems[2]) && lineItems[2] != string.Empty)
                            {
                                map_locations.Add(lineItems[2]);
                            }

                            lines.Add(lineItems);
                        }

                        index++;
                    }
                }

                using (SqlConnection conn = new SqlConnection(SqlConString))
                {
                    conn.Open();

                    foreach (var item in types)
                    {
                        string inLineSQL_type = $@"INSERT INTO {Types} {TypeHeaders} VALUES ('{item}')";
                        using (var command = new SqlCommand(inLineSQL_type, conn))
                        {
                            var query = command.ExecuteNonQuery();
                        }
                    }

                    foreach (var item in map_locations)
                    {
                        string inLineSQL_map = $@"INSERT INTO {Map_Locations} {MapHeaders} VALUES ('{item}', '{GenerateRandomHeading()}')";
                        using (var command = new SqlCommand(inLineSQL_map, conn))
                        {
                            var query = command.ExecuteNonQuery();
                        }
                    }

                    foreach (var item in lines)
                    {
                        string typeID = string.Empty;
                        string MapID = string.Empty;

                        string inLineSql_getTypeID = $@"SELECT TOP 1 ID FROM {Types} WHERE Type = '{item[1]}' ORDER BY ID DESC";
                        string inLineSql_getMapID = $@"SELECT TOP 1 ID FROM {Map_Locations} WHERE Map_Location = '{item[2]}' ORDER BY ID DESC";

                        using (var command = new SqlCommand(inLineSql_getTypeID, conn))
                        {
                            var reader = command.ExecuteReader();

                            while (reader.Read())
                            {
                                typeID = reader.GetValue(0)?.ToString() ?? @"NULL";
                            }

                            reader.Close();
                        }

                        using (var command = new SqlCommand(inLineSql_getMapID, conn))
                        {
                            var reader = command.ExecuteReader();

                            while (reader.Read())
                            {
                                MapID = reader.GetValue(0)?.ToString() ?? @"NULL";
                            }

                            reader.Close();
                        }

                        if (typeID == "")
                        {
                            typeID = @"NULL";
                        }
                        if (MapID == "")
                        {
                            MapID = @"NULL";
                        }

                        int? characterID = null;
                        string inLineSql_primary = $@"INSERT INTO {TableName} {CharacterHeaders} VALUES ('{item[0]}', {typeID}, {MapID})";
                        

                        using (var command = new SqlCommand(inLineSql_primary, conn))
                        {
                            var query = command.ExecuteNonQuery();
                        }

                        string inLineSqlGetID = $@"SELECT TOP 1 ID FROM {TableName} ORDER BY ID DESC";

                        // get the id of the most recent insert in the parent table, derived from example by Sebastian
                        using (var command = new SqlCommand(inLineSqlGetID, conn))
                        {
                            var reader = command.ExecuteReader();

                            while (reader.Read())
                            {
                                characterID = (int)reader.GetValue(0);
                            }

                            reader.Close();
                        }

                        string inLineSql_secondary = $@"INSERT INTO {ChildTableName} {InfoHeaders} VALUES ('{characterID}', '{item[3]}', '{item[4]}', '{item[5]}')";

                        using (var command = new SqlCommand(inLineSql_secondary, conn))
                        {
                            var query = command.ExecuteNonQuery();
                        }

                    }

                    conn.Close();
                }
            }
            catch (IOException ioe)
            {
                errors.Add(new Error(ioe.Message, ioe.Source));
            }
            catch (Exception e)
            {
                errors.Add(new Error(e.Message, e.Source));
            }

            return errors;
        }

        /// <summary>
        /// Generate a random heading for the map_location
        /// </summary>
        /// <returns></returns>
        string GenerateRandomHeading()
        {
            Random rand = new Random();
            string[] headings = { "N", "S", "E", "W" };
            return headings[rand.Next(headings.Length)];
        }

        /// <summary>
        /// Convert empty results to a more readable value
        /// </summary>
        /// <param name="init"></param>
        /// <returns></returns>
        string ConvertEmptyValue(string init)
        {
            if (init == null || init == string.Empty)
            {
                return "null";
            }
            return init;
        }

        /// <summary>
        /// Export a dictionary of data previously collected to a new file with filename and the header specified by params
        /// </summary>
        /// <param name="newFileName">name for the new file</param>
        /// <param name="includedColumns">columns included in this export, to be displayed at the top of the exported file</param>
        /// <param name="data">dictionary of data collected through SQL commands</param>
        /// <returns></returns>
        private List<Error> ExportData(string newFileName, string includedColumns, Dictionary<int, List<string>> data)
        {
            List<Error> errors = new List<Error>();
            string writePath = Path.Combine(directoryPath, newFileName);

            try
            {
                if (File.Exists(writePath))
                {
                    File.Delete(writePath);
                }

                using (StreamWriter sw = new StreamWriter(writePath, true))
                {
                    sw.WriteLine($"Processed at: {DateTime.Now}");
                    sw.WriteLine();
                    sw.WriteLine(includedColumns);

                    foreach (var item in data)
                    {
                        string temp = "";
                        for (int i = 0; i < item.Value.Count; i++)
                        {
                            if (i == item.Value.Count - 1)
                            {
                                temp += item.Value[i];
                            }
                            else
                            {
                                temp += $"{item.Value[i]}|";
                            }
                        }
                        sw.WriteLine(temp);
                    }
                }
            }
            catch (IOException ioe)
            {
                errors.Add(new Error(ioe.Message, ioe.Source));
            }
            catch (Exception e)
            {
                errors.Add(new Error(e.Message, e.Source));
            }


            return errors;
        }

        /// <summary>
        /// Read all data from the Character and Character_Info tablesusing join and write the report to a file titled FullReport.txt
        /// </summary>
        /// <returns></returns>
        private List<Error> FullReport()
        {
            List<Error> errors = new List<Error>();
            Dictionary<int, List<string>> lines = new Dictionary<int, List<string>>();
            int fields = 7;

            try
            {
                using (SqlConnection conn = new SqlConnection(SqlConString))
                {
                    conn.Open();

                    string inLineSql_primary = @$"SELECT * FROM [dbo].[vw_FullReport]";

                    using (var command = new SqlCommand(inLineSql_primary, conn))
                    {
                        var reader = command.ExecuteReader();
                        int index = 0;
                        while(reader.Read())
                        {
                            List<string> temp = new List<string>();
                            for (int i = 0; i < fields; i++)
                            {
                                temp.Add(ConvertEmptyValue($"{reader.GetValue(i)}"));
                            }
                            lines.Add(index++, temp);
                        }

                        reader.Close();

                    }

                    conn.Close();
                }

                string columNames = "ID,Character,Type,Map_Location,Original_Character,Sword_Fighter,Magic_User";
                ExportData("FullReport.txt", columNames, lines);

            }
            catch (IOException ioe)
            {
                errors.Add(new Error(ioe.Message, ioe.Source));
            }
            catch (Exception e)
            {
                errors.Add(new Error(e.Message, e.Source));
            }


            return errors;
        }

        /// <summary>
        /// Uses a join to find all characters without a value for their map_location field before writing data to a file titled Lost.txt
        /// </summary>
        /// <returns></returns>
        private List<Error> FindMaplessCharacters()
        {
            List<Error> errors = new List<Error>();
            Dictionary<int, List<string>> lines = new Dictionary<int, List<string>>();
            int fields = 1;

            try
            {
                using (SqlConnection conn = new SqlConnection(SqlConString))
                {
                    conn.Open();

                    string spName = $@"[dbo].[sp_FindMaplessCharacters]";

                    using (var command = new SqlCommand(spName, conn))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        var reader = command.ExecuteReader();
                        int index = 0;
                        while (reader.Read())
                        {
                            List<string> temp = new List<string>();
                            for (int i = 0; i < fields; i++)
                            {
                                temp.Add(ConvertEmptyValue($"{reader.GetValue(i)}"));
                            }
                            lines.Add(index++, temp);
                        }

                        reader.Close();

                    }

                    conn.Close();
                }

                string columNames = "Character";
                ExportData("Lost.txt", columNames, lines);

            }
            catch (IOException ioe)
            {
                errors.Add(new Error(ioe.Message, ioe.Source));
            }
            catch (Exception e)
            {
                errors.Add(new Error(e.Message, e.Source));
            }


            return errors;
        }

        /// <summary>
        /// find all characters with any type other than human who also are sword wielders before writing data to a file titled SwordNonHuman.txt
        /// </summary>
        /// <returns></returns>
        private List<Error> FindSwordNonHuman()
        {
            List<Error> errors = new List<Error>();
            Dictionary<int, List<string>> lines = new Dictionary<int, List<string>>();
            int fields = 2;

            try
            {
                using (SqlConnection conn = new SqlConnection(SqlConString))
                {
                    conn.Open();

                    string spName = $@"[dbo].[sp_FindSwordNonHuman]";

                    using (var command = new SqlCommand(spName, conn))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        var reader = command.ExecuteReader();
                        int index = 0;
                        while (reader.Read())
                        {
                            List<string> temp = new List<string>();
                            for (int i = 0; i < fields; i++)
                            {
                                temp.Add(ConvertEmptyValue($"{reader.GetValue(i)}"));
                            }
                            lines.Add(index++, temp);
                        }

                        reader.Close();

                    }

                    conn.Close();
                }

                string columNames = "ID, Character";
                ExportData("SwordNonHuman.txt", columNames, lines);

            }
            catch (IOException ioe)
            {
                errors.Add(new Error(ioe.Message, ioe.Source));
            }
            catch (Exception e)
            {
                errors.Add(new Error(e.Message, e.Source));
            }


            return errors;
        }

        /// <summary>
        /// Export data from BinaryConversion view
        /// </summary>
        /// <returns></returns>
        private List<Error> BinaryCharacterInfo()
        {
            List<Error> errors = new List<Error>();
            Dictionary<int, List<string>> lines = new Dictionary<int, List<string>>();
            int fields = 6;

            try
            {
                using (SqlConnection conn = new SqlConnection(SqlConString))
                {
                    conn.Open();

                    string inLineSql_primary = @$"SELECT * FROM [dbo].[vw_BinaryConversion]";

                    using (var command = new SqlCommand(inLineSql_primary, conn))
                    {
                        var reader = command.ExecuteReader();
                        int index = 0;
                        while (reader.Read())
                        {
                            List<string> temp = new List<string>();
                            for (int i = 0; i < fields; i++)
                            {
                                temp.Add(ConvertEmptyValue($"{reader.GetValue(i)}"));
                            }
                            lines.Add(index++, temp);
                        }

                        reader.Close();

                    }

                    conn.Close();
                }

                string columNames = "ID,Character,Original_Character,Sword_Fighter,Magic_User,Binary";
                ExportData("BinaryReport.txt", columNames, lines);

            }
            catch (IOException ioe)
            {
                errors.Add(new Error(ioe.Message, ioe.Source));
            }
            catch (Exception e)
            {
                errors.Add(new Error(e.Message, e.Source));
            }

            return errors;
        }
    }
}
