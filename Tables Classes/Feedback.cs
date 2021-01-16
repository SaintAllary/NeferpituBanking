using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NeferpituBanking.Tables_Classes
{
    public class Feedback : GET_Requests_Result, IComparable<Feedback>
    {


        public Feedback(GET_Feedbacks_Result feedback)
        {

            this.Date_CustomerRequest = new DateTime?(DateTime.Parse(feedback.Date_SupportResponse.Value.ToString()));
            this.Desciption_CustomerRequest = feedback.Answer_SupportResponse;
            this.Caption_CustomerRequest = "(Support feedback)";


        }
        public Feedback(GET_Requests_Result feedback)
        {

            this.Date_CustomerRequest = new DateTime?(DateTime.Parse(feedback.Date_CustomerRequest.Value.ToString()));
            this.Desciption_CustomerRequest = feedback.Desciption_CustomerRequest;
            this.Caption_CustomerRequest = feedback.Caption_CustomerRequest;




        }


        //public int Compare(Feedback x, Feedback y)
        //{
        //    if (x.Date_CustomerRequest.Value < y.Date_CustomerRequest.Value)
        //    {
        //        return 1;
        //    }
        //    else if (x.Date_CustomerRequest.Value > y.Date_CustomerRequest.Value)
        //    {
        //        return -1;
        //    }

        //    else
        //    {
        //        return 0;
        //    }
        //}

        public int CompareTo(Feedback other)
        {
            if (this.Date_CustomerRequest.Value < other.Date_CustomerRequest.Value)
            {
                return 1;
            }
            else if (this.Date_CustomerRequest.Value > other.Date_CustomerRequest.Value)
            {
                return -1;
            }

            else
            {
                return 0;

            }
        }
    }
}