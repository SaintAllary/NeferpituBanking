using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace NeferpituBanking
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void DragWindow(object sender, MouseButtonEventArgs e)
        {
            if (e.LeftButton == MouseButtonState.Pressed)
            {
                DragMove();
            }
          
        }
        private void EnterBanking(object sender, RoutedEventArgs e)
        {
            NeferpituBankingEntities neferpituBankingEntities = new NeferpituBankingEntities();

            var obj = new System.Data.Entity.Core.Objects.ObjectParameter("User_signed_Id", typeof(int));
            neferpituBankingEntities.CHECK__SignIn("admin", "admin", obj);
            Hide();
            MessageBox.Show(obj.Value.ToString());
            UserBanking userBanking = new UserBanking();
            userBanking.Show();
            Close();
        }
    }
}
