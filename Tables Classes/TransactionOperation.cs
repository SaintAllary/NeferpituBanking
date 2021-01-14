using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NeferpituBanking.Tables_Classes
{
    public class TransactionOperation
    {
        public TransactionOperation()
        {
            DestinationCard = null;
            MoneyValue = null;
        }
        public Nullable<long>  DestinationCard { get; set; }
        public Nullable<decimal> MoneyValue { get; set; }

        //public void ExecSendOperation(int ownerCard)
        //{
        //    NeferpituBankingEntities neferpituBankingEntities = new NeferpituBankingEntities();

        //    neferpituBankingEntities.DO__Transaction(MoneyValue, ownerCard, DestinationCard);
        //}
    
    }
}
