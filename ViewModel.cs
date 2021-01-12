using GalaSoft.MvvmLight.Command;
using NeferpituBanking.Exceptions;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace NeferpituBanking
{

    class ViewModel : NeferpituBankingEntities, INotifyPropertyChanged
    {
        private string password;
        public string Password
        {
            get => password;
            set
            {
                password = value;
                OnPropertyChanged(nameof(password));
            }
        }

        private string login;
        public string Login
        {
            get => login;
            set
            {
                login = value;
                OnPropertyChanged(nameof(login));
            }
        }

        public ViewModel()
        {

        }

        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged([CallerMemberName] string prop = "")
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
        }


        public ICommand UserSignIn => new RelayCommand(() =>
         {
           
             try
             {
                 var obj = new System.Data.Entity.Core.Objects.ObjectParameter(Properties.Resources.UserId__DB_name, typeof(int));
                 CHECK__SignIn(login, password, obj);
                 //var s = GET_AllUsersCards(Convert.ToInt32(obj.Value), Login, Password);
                 //s.ToList().ForEach(x => MessageBox.Show(x.Code_Card.ToString()));

                 if (obj.Value is DBNull) throw new InvalidAuthorize();
                 if (Convert.ToInt32(obj.Value) >= 1)
                 {
                     Application.Current.MainWindow.Hide();
                     UserBanking userBanking = new UserBanking();
                     userBanking.Show();
                     Application.Current.MainWindow.Close();

                 }
                
             }
             catch (Exception ex)
             {
                 MessageBox.Show(ex.Message);
             }
             

         });
    }
}
