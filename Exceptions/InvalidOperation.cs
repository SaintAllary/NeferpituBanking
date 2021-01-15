using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NeferpituBanking.Exceptions
{
    class InvalidOperation: Exception
    {
        public InvalidOperation():base("Invalid operation, your value seems to be not correct")
        {

        }
    }
}
