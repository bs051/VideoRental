using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;
using System.Data.SqlClient;

namespace VideoRental
{
    public partial class VideosRental : Form
    {
        // All SQl Classes instances
        SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["VideoRentalConnString"].ConnectionString);
        SqlCommand sqlCommand = new SqlCommand();
        SqlDataReader sqlDataReader;
        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
        DatabaseHelper sqlDatabase = new DatabaseHelper();
        //ctor
        public VideosRental()
        {
            InitializeComponent();
        }

        private void VideosRental_Load(object sender, EventArgs e)
        {
            //fill all data into data grids at loading

            FillCustomerGrid();
            FillVideoGrid();
            FillRentedVideoGrid();
            TotalRented();
            VideoRentedMost();

        }
        
        // to fill customer grid
        public void FillCustomerGrid()
        {
            DataSet dsCustomer = new DataSet();
            sqlCommand = new SqlCommand("select * from Customer", sqlConnection);
            sqlDataAdapter.SelectCommand = sqlCommand;
            dsCustomer.Clear();
            sqlDataAdapter.Fill(dsCustomer, "Customer");
            custGrid.DataSource = dsCustomer.Tables["Customer"];
        }
        // to fill video grid
        private void FillVideoGrid()
        {
            DataSet dsMovie = new DataSet();
            sqlCommand = new SqlCommand("select * from Movie", sqlConnection);
            sqlDataAdapter.SelectCommand = sqlCommand;
            dsMovie.Clear();
            sqlDataAdapter.Fill(dsMovie, "Movie");
            gridVideo.DataSource = dsMovie.Tables["Movie"];
        }
        // to fill rented video grid
        private void FillRentedVideoGrid()
        {
            DataSet dsRentedMovie = new DataSet();
            sqlCommand = new SqlCommand("select * from RentedMoviesView", sqlConnection);
            sqlDataAdapter.SelectCommand = sqlCommand;
            dsRentedMovie.Clear();
            sqlDataAdapter.Fill(dsRentedMovie, "RentedMoviesView");
            gridRentedMovie.DataSource = dsRentedMovie.Tables["RentedMoviesView"];
        }

        private void btnAddCustomer_Click(object sender, EventArgs e)
        {
            InsertNewCustomerAndValidate(); // Insert new Customer
            
        }
        public void InsertNewCustomerAndValidate()
        {
            // check for emtpy fields
            if (string.IsNullOrEmpty(txtFirstName.Text))
            {
                MessageBox.Show("Please Enter First Name");
                return;
            }
            else if (string.IsNullOrEmpty(txtLastName.Text))
            {
                MessageBox.Show("Please Enter Last Name");
                return;
            }
            else if (string.IsNullOrEmpty(txtAddress.Text))
            {
                MessageBox.Show("Please Enter Address");
                return;
            }
            else if (string.IsNullOrEmpty(txtPhone.Text))
            {
                MessageBox.Show("Please Enter Phone No");
                return;
            }
            // add customer and clear boxes
            try
            {
                sqlDatabase.AddCustomer(txtFirstName.Text, txtLastName.Text, txtAddress.Text, txtPhone.Text);
                lblId.Text = "";
                lblMovieId.Text = "";
                lblRMID.Text = "";
                ClearTextBoxes();
                FillCustomerGrid();
                tabControl1.SelectedIndex = 0;
                MessageBox.Show("Customer Added successfully","Info",MessageBoxButtons.OK,MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
        private void custGrid_Click(object sender, EventArgs e)
        {
            // select customer from grid
            if (custGrid.Rows.Count > 0)
            {
                lblId.Text = custGrid.CurrentRow.Cells[0].Value.ToString();
                txtFirstName.Text = custGrid.CurrentRow.Cells[1].Value.ToString();
                txtLastName.Text = custGrid.CurrentRow.Cells[2].Value.ToString();
                txtAddress.Text = custGrid.CurrentRow.Cells[3].Value.ToString();
                txtPhone.Text = custGrid.CurrentRow.Cells[4].Value.ToString();
                
            }
        }

        private void btnUpdateCustomer_Click(object sender, EventArgs e)
        {
            
            try
            {
                if (string.IsNullOrEmpty(lblId.Text))
                {
                    MessageBox.Show("Please Select Customer First", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    return;
                }
                sqlDatabase.EditCustomer(Convert.ToInt32(lblId.Text), txtFirstName.Text, txtLastName.Text, txtAddress.Text, txtPhone.Text);

                lblId.Text = "";
                ClearTextBoxes();
                FillCustomerGrid();
                tabControl1.SelectedIndex = 0;
                MessageBox.Show("Customer Updated Successfully", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
               
            

            
        }
        // merthod to clear text boxes
        private void ClearTextBoxes()
        {
            Action<Control.ControlCollection> func = null;

            func = (controls) =>
            {
                foreach (Control control in controls)
                {
                    if (control is TextBox)
                        (control as TextBox).Clear();
                    else
                        func(control.Controls);
                }
            };

            func(Controls);
            txtCost.Text = "Auto";
        }

        private void btnDeleteCustomer_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(lblId.Text))
            {
              
                MessageBox.Show("Please Select Customer First", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);

                return;
            }
            // confirm deletion dialog box
            DialogResult dialogResult = MessageBox.Show("ARE YOU SURE YOU WANT TO DELETE THIS Customer ?", "Customer Delete", MessageBoxButtons.YesNo,MessageBoxIcon.Warning);
            if (dialogResult == DialogResult.Yes)
            {
                try
                {

                    sqlDatabase.DeleteCustomer(Convert.ToInt32(lblId.Text));
                  
                    MessageBox.Show("Customer Deleted Successfully", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    ClearTextBoxes();
                    lblId.Text = "";
                    FillCustomerGrid();
                   
                }
                catch(Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }

              
            }
            else if (dialogResult == DialogResult.No)
            {
               
            }
        }

    
        private void btnAddMovie_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtTitle.Text))
            {
              
                MessageBox.Show("Please Enter Video Title", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);

                return;
            }
            else if (string.IsNullOrEmpty(txtCost.Text))
            {
          
                MessageBox.Show("Please Enter Rental Cost", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);

                return;
            }

            try
            {
                sqlDatabase.AddVideo(txtTitle.Text, dtpReleaseDate.Value.Date, Convert.ToDecimal(txtCost.Text), txtGenre.Text, txtPlot.Text);

                lblId.Text = "";
                lblMovieId.Text = "";
                lblRMID.Text = "";
                ClearTextBoxes();
                FillVideoGrid();
                tabControl1.SelectedIndex = 1;
              
                MessageBox.Show("Video Added Successfully", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
         
        }

        private void gridVideo_Click(object sender, EventArgs e)
        {
            if (gridVideo.Rows.Count > 0)
            {
                lblMovieId.Text = gridVideo.CurrentRow.Cells[0].Value.ToString();
                txtTitle.Text = gridVideo.CurrentRow.Cells[1].Value.ToString();
                dtpReleaseDate.Text = gridVideo.CurrentRow.Cells[2].Value.ToString();
                txtCost.Text = gridVideo.CurrentRow.Cells[3].Value.ToString();
                txtGenre.Text = gridVideo.CurrentRow.Cells[4].Value.ToString();
                txtPlot.Text = gridVideo.CurrentRow.Cells[5].Value.ToString();

            }
        }

        private void btnUpdateMovie_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(lblMovieId.Text))
            {
             
                MessageBox.Show("Please Select Movie First", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);

                return;
            }
            try { 
           sqlDatabase.EditVideo(Convert.ToInt32(lblMovieId.Text),txtTitle.Text, dtpReleaseDate.Value.Date, Convert.ToDecimal(txtCost.Text), txtGenre.Text, txtPlot.Text);
            
                lblMovieId.Text = "";
                ClearTextBoxes();
                FillVideoGrid();
                tabControl1.SelectedIndex = 1;

                MessageBox.Show("Video updated successfully", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);


            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
            
        }

        private void btnDeleteMovie_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(lblMovieId.Text))
            {

                MessageBox.Show("Please Select the video", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            DialogResult dialogResult = MessageBox.Show("ARE YOU SURE YOU WANT TO DELETE THIS Video ?", "Record Delete", MessageBoxButtons.YesNo,MessageBoxIcon.Warning);
            if (dialogResult == DialogResult.Yes)
            {
                try { 
                sqlDatabase.DeleteVideo(Convert.ToInt32(lblMovieId.Text));         
                   
                    MessageBox.Show("Video Deleted Successfully", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    ClearTextBoxes();
                    lblMovieId.Text = "";
                    FillVideoGrid();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.ToString());
                }
               
            }
            else if (dialogResult == DialogResult.No)
            {
                
            }
        }

        private void btnIssueMovie_Click(object sender, EventArgs e)
        {
            if(string.IsNullOrEmpty(lblId.Text) || string.IsNullOrEmpty(lblMovieId.Text))
            {
               
                MessageBox.Show("Please select a customer and movie for renting purposes", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);

                return;
            }
            // check if video is rented
            var alreadyRental = 0;
            sqlConnection.Open();
            sqlCommand = new SqlCommand("Select * from RentedMovies where MovieId=@MovieId and DateReturned is NULL", sqlConnection);
            sqlCommand.Parameters.AddWithValue("@MovieId", lblMovieId.Text);
            sqlDataReader = sqlCommand.ExecuteReader();
            if(sqlDataReader.Read())
            {
                alreadyRental = 1; // is rented
            }
            else
            {
                alreadyRental = 0; // is not rented
            }
            sqlDataReader.Close();
            sqlConnection.Close();
            if(alreadyRental==1)
            {
                
                MessageBox.Show("Video Alreaded Rented", "Info", MessageBoxButtons.OK, MessageBoxIcon.Error);

                return;
            }
            // add rented video if not rented previously
            try { 
            sqlDatabase.AddRentalVideo(Convert.ToInt32(lblMovieId.Text), Convert.ToInt32(lblId.Text));

                MessageBox.Show("Video Rented Successfully", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);
                lblId.Text = "";
                lblMovieId.Text = "";
                ClearTextBoxes();
                FillRentedVideoGrid();
                TotalRented();
                VideoRentedMost();

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
         
        }

        private void gridRentedMovie_Click(object sender, EventArgs e)
        {
            // select rented movie from view
            if (gridRentedMovie.Rows.Count > 0)
            {
                lblRMID.Text = gridRentedMovie.CurrentRow.Cells["RMID"].Value.ToString();
                lblId.Text = gridRentedMovie.CurrentRow.Cells["CustId"].Value.ToString();
                txtFirstName.Text = gridRentedMovie.CurrentRow.Cells["FirstName"].Value.ToString();
                txtLastName.Text = gridRentedMovie.CurrentRow.Cells["LastName"].Value.ToString();
                txtAddress.Text = gridRentedMovie.CurrentRow.Cells["Address"].Value.ToString();
                txtPhone.Text = gridRentedMovie.CurrentRow.Cells["Phone"].Value.ToString();
                lblMovieId.Text = gridRentedMovie.CurrentRow.Cells["MovieId"].Value.ToString();
                txtTitle.Text = gridRentedMovie.CurrentRow.Cells["Title"].Value.ToString();
                dtpReleaseDate.Text = gridRentedMovie.CurrentRow.Cells["ReleaseDate"].Value.ToString();
                txtCost.Text = gridRentedMovie.CurrentRow.Cells["RentalCost"].Value.ToString();
                txtGenre.Text = gridRentedMovie.CurrentRow.Cells["Genre"].Value.ToString();
                txtPlot.Text = gridRentedMovie.CurrentRow.Cells["Plot"].Value.ToString();

            }
        }

        private void btnReturnMovie_Click(object sender, EventArgs e)
        {
            // return a movie by usng rented movie id
            if(string.IsNullOrEmpty(lblRMID.Text))
            {
           
                MessageBox.Show("Please Select the rented movie", "Info", MessageBoxButtons.OK, MessageBoxIcon.Error);
                tabControl1.SelectedIndex = 2;
                return;
            }
            sqlConnection.Open();
            // check if video is rented or not
            var alreadyReturned = 0;
            sqlCommand = new SqlCommand("Select * from RentedMovies where RentedMovieId=@RentedMovieId and DateReturned is Not NULL", sqlConnection);
            sqlCommand.Parameters.AddWithValue("@RentedMovieId", lblRMID.Text);
            sqlDataReader = sqlCommand.ExecuteReader();
            if (sqlDataReader.Read())
            {
                alreadyReturned = 1; // is not rented
            }
            else
            {
                alreadyReturned = 0; // is rented
            }
            sqlDataReader.Close();
            sqlConnection.Close();
            if(alreadyReturned==1) // if not rented then video is already returned
            {
               
                MessageBox.Show("Video Alreaded Reterned", "Info", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            // otherwise return a movie
            try { 
            sqlDatabase.Returned(Convert.ToInt32(lblRMID.Text));
            

                MessageBox.Show("Video renturned successfully", "Info", MessageBoxButtons.OK, MessageBoxIcon.Information);
                lblId.Text = "";
                lblMovieId.Text = "";
                lblRMID.Text = "";
                ClearTextBoxes();
                tabControl1.SelectedIndex = 2;
                FillRentedVideoGrid();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void btnShowRentedVideo_Click(object sender, EventArgs e)
        {
            tabControl1.SelectedIndex = 2;
            FillRentedVideoGrid();
        }

        private void dtpReleaseDate_ValueChanged(object sender, EventArgs e)
        {
            // if movie is released 5 years ago then rent is 2 else 5
            if(dtpReleaseDate.Value.Date<=DateTime.Now.Date.AddYears(-5))
            {
                txtCost.Text = "2";
            }
            else
            {
                txtCost.Text = "5";
            }
        }
        private void TotalRented()
        {
            DataSet dsTotalRented = new DataSet();
            sqlCommand = new SqlCommand("select CustId,FirstName,LastName,Address,Phone,Count(*) as 'Total Rented' from RentedMoviesView group by CustId,FirstName,LastName,Address,Phone order by 'Total Rented' desc", sqlConnection);
            sqlDataAdapter.SelectCommand = sqlCommand;
            dsTotalRented.Clear();
            sqlDataAdapter.Fill(dsTotalRented, "RentedMoviesView");
            gridMostBorrow.DataSource = dsTotalRented.Tables["RentedMoviesView"];
        }
        private void VideoRentedMost()
        {
            DataSet ds = new DataSet();
            sqlCommand = new SqlCommand("select MovieId,Title,ReleaseDate,RentalCost,Genre,Count(*) as 'Total Rented By' from RentedMoviesView group by MovieId,Title,ReleaseDate,RentalCost,Genre order by 'Total Rented By' desc", sqlConnection);
            sqlDataAdapter.SelectCommand = sqlCommand;
            ds.Clear();
            sqlDataAdapter.Fill(ds, "RentedMoviesView");
            gridPopularVideo.DataSource = ds.Tables["RentedMoviesView"];
        }

        private void txtPhone_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = !char.IsDigit(e.KeyChar) && !char.IsControl(e.KeyChar);
        }

        private void txtCost_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = !char.IsDigit(e.KeyChar) && !char.IsControl(e.KeyChar);
        }

        private void tabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(tabControl1.SelectedIndex==2)
            {
                FillRentedVideoGrid();
            }
        }

        private void btnRentedOut_Click(object sender, EventArgs e)
        {
            tabControl1.SelectedIndex = 2;
            DataSet dsRentedMovie = new DataSet();
            sqlCommand = new SqlCommand("select * from RentedMoviesView where DateReturned is Null", sqlConnection);
            sqlDataAdapter.SelectCommand = sqlCommand;
            dsRentedMovie.Clear();
            sqlDataAdapter.Fill(dsRentedMovie, "RentedMoviesView");
            gridRentedMovie.DataSource = dsRentedMovie.Tables["RentedMoviesView"];
        }

        private void btnMostborrow_Click(object sender, EventArgs e)
        {
            tabControl1.SelectedIndex = 3;
            TotalRented();
        }

        private void btnMostPopular_Click(object sender, EventArgs e)
        {
            tabControl1.SelectedIndex = 4;
            VideoRentedMost();
        }
    }
    

}
