using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NeferpituBanking.Exceptions
{
   public class InvalidAuthorize : Exception
    {

        public InvalidAuthorize():base("Invalid authorization, try to write correct values")
        {

        }
    }
}
