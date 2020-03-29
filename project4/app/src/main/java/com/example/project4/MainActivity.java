package com.example.project4;


import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import android.database.Cursor;

public class MainActivity extends AppCompatActivity {

    TextView balance;
    TextView history;
    DataBaseManagement DataBaseManagementDB;
    EditText Date, Price, Item;
    Button Add, Sub;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);
        Item = (EditText) findViewById(R.id.Item);
        Add = (Button) findViewById(R.id.Add);
        Date = (EditText) findViewById(R.id.Date);
        history = (TextView) findViewById(R.id.history);
        DataBaseManagementDB = new DataBaseManagement(this);
        Price = (EditText) findViewById(R.id.Price);
        Sub = (Button) findViewById(R.id.Sub);
        balance = (TextView) findViewById(R.id.balance);
        addHistory();
        retHistory();
    }

    public void addHistory(){
        Add.setOnClickListener(
                new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        double price = Double.parseDouble(Price.getText().toString());
                        boolean result = DataBaseManagementDB.createHistory(Item.getText().toString(), Date.getText().toString(), price);
                        if (result)
                            Toast.makeText(MainActivity.this, "Successfully Created", Toast.LENGTH_LONG).show();
                        else
                            Toast.makeText(MainActivity.this, "Failed to Create", Toast.LENGTH_LONG).show();
                        retHistory();
                        MainActivity.this.Date.setText("");
                        MainActivity.this.Price.setText("");
                        MainActivity.this.Item.setText("");
                    }
                }
        );

        Sub.setOnClickListener(
                new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        double price = -1 * Double.parseDouble(Price.getText().toString());
                        boolean result = DataBaseManagementDB.createHistory(Item.getText().toString(), Date.getText().toString(), price);
                        if (result)
                            Toast.makeText(MainActivity.this, "Successfully Created", Toast.LENGTH_LONG).show();
                        else
                            Toast.makeText(MainActivity.this, "Failed to Create", Toast.LENGTH_LONG).show();
                        retHistory();
                        MainActivity.this.Date.setText("");
                        MainActivity.this.Price.setText("");
                        MainActivity.this.Item.setText("");
                    }
                }
        );
    }

    public void retHistory(){
        Cursor result = DataBaseManagementDB.pullData();
        StringBuffer str = new StringBuffer();
        Double balance = 0.0;

        while(result.moveToNext()){
            String priceString = result.getString(3);
            double price = Double.parseDouble(result.getString(3));
            balance += price;

                if (price < 0) {
                    str.append("Spent $");
                    priceString = priceString.substring(1);
                }
                else {
                str.append("Added $");
            }
            str.append(priceString + " on " + result.getString(2)
                    + " for " + result.getString(1) + "\n");
        }
        MainActivity.this.balance.setText("Current Balance: $" + Double.toString(balance));
        MainActivity.this.history.setText(str);
    }
}
