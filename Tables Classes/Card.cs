using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NeferpituBanking.Tables_Classes
{
    public class Card
    {
        public CardPrivate CardPrivate { get; set; }
        public string BankName { get; set; }
        public long Id { get; set; }
        public string Code { get; set; }
        public long? BalanceId { get; set; }
        public long? TypeId { get; set; }
        public long? LimitId { get; set; }
        public long? StateId { get; set; }
        public long? PaymentCompanyId { get; set; }
        public Card(long Id,string Code, long BalanceId, long TypeId, long LimitId, long StateId, long PaymentCompanyId,CardPrivate cardPrivate)
        {
            //this.BankName = bankName;
            this.Id = Id;
            this.Code = Code;
            this.BalanceId = BalanceId;
            this.TypeId = TypeId;
            this.LimitId = LimitId;
            this.StateId = StateId;
            this.PaymentCompanyId = PaymentCompanyId;
            CardPrivate = cardPrivate;

        }
      
    }
}
