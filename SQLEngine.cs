using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using static Week7Databases.Constants;

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

        private List<Error> Insert()
        {
            List<Error> errors = new List<Error>();
            List<string[]> lines = new List<string[]>();

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
                            lines.Add(lineItems);
                        }

                        index++;
                    }
                }

                using (SqlConnection conn = new SqlConnection(SqlConString))
                {
                    conn.Open();

                    foreach (var item in lines)
                    {
                        int? characterID = null;
                        string inLineSql_primary = $@"INSERT INTO {TableName} {primaryHeaders} VALUES ('{item[0]}')";
                        

                        using (var command = new SqlCommand(inLineSql_primary, conn))
                        {
                            var query = command.ExecuteNonQuery();
                        }

                        string inLineSqlGetID = $@"SELECT * FROM {TableName} ORDER BY ID DESC LIMIT 1";

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

                        string inLineSql_secondary = $@"INSERT INTO {ChildTableName} {secondaryHeaders} VALUES ('{characterID}', '{item[1]}', '{item[2]}', '{item[3]}', '{item[4]}', '{item[5]}')";

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

        string ConvertEmptyValue(string init)
        {
            if (init == null || init == string.Empty)
            {
                return "null";
            }
            return init;
        }

        // "ID,Name,Location,Price,UoM,Sell_by_Date"

        private List<Error> ExportData(string writePath, string includedColumns, Dictionary<int, List<string>> data)
        {
            List<Error> errors = new List<Error>();

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

                    string inLineSql_primary = $@"SELECT {TableName}.ID, {TableName}.Character, {ChildTableName}.Type, {ChildTableName}.Map_Location, {ChildTableName}.Original_Character, {ChildTableName}.Sword_Fighter, {ChildTableName}.Magic_User
                                                FROM {TableName} 
                                                INNER JOIN {ChildTableName} 
                                                ON {TableName}.ID = {ChildTableName}.CharacterID";


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

                    string inLineSql_primary = $@"SELECT {TableName}.Character
                                                FROM {TableName} 
                                                LEFT JOIN {ChildTableName} 
                                                ON {TableName}.ID = {ChildTableName}.CharacterID
                                                WHERE {ChildTableName}.Map_Location is NULL";


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


        private List<Error> FindSwordNonHuman()
        {
            List<Error> errors = new List<Error>();
            Dictionary<int, List<string>> lines = new Dictionary<int, List<string>>();
            int fields = 7;

            try
            {
                using (SqlConnection conn = new SqlConnection(SqlConString))
                {
                    conn.Open();

                    string inLineSql_primary = $@"SELECT {TableName}.Character
                                                FROM {TableName} 
                                                LEFT JOIN {ChildTableName} 
                                                ON {TableName}.ID = {ChildTableName}.CharacterID
                                                WHERE {ChildTableName}.Map_Location is NULL";


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

    }

}
