using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Week7Databases
{
    internal class Constants
    {
        private const string folderName = "temp";

        public static string directoryPath => Path.Combine(Directory.GetCurrentDirectory(), folderName);

        public static string Characters => "[dbo].[Characters]";

        public static string Character_Info => "[dbo].[Character_Info]";

        public static string Types => "[dbo].[Types]";

        public static string Map_Locations => "[dbo].[Map_Locations]";

        public static string CharacterHeaders => "([Character], [TypeID], [MapLocationID])";

        public static string InfoHeaders => "([CharacterID], [Original_Character], [Sword_Fighter], [Magic_User])";

        public static string TypeHeaders => "([Type])";

        public static string MapHeaders => "([Map_Location], [Heading])";
    }
}
