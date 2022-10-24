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

        public static string parentDatabaseName => "[dbo].[Characters]";

        public static string childDatabaseName => "[dbo].[Character_Info]";

        public static string primaryHeaders => "([Character])";

        public static string secondaryHeaders => "([CharacterID], [Type], [Original_Character], [Map_Location], [Sword_Fighter], [Magic_User])";
    }
}
