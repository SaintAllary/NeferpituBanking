using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NeferpituBanking.Tables_Classes
{
     public class CardPrivate
    {

        public CardPrivate(string CVV, string ExpiredDate)
        {
            this.CVV = CVV;
            this.ExpiredDate = ExpiredDate;
        }
        public string CVV { get; set; }
        public string ExpiredDate { get; set; }
    }
}
