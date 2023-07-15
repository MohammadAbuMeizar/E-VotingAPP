package com.examplee.votinga;

import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class login extends AppCompatActivity {



    EditText emai;
    EditText pass;
    Button login;



    String x="National number";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login); getSupportActionBar().setDisplayShowTitleEnabled(false);
        getSupportActionBar().hide();



        login=(Button)findViewById(R.id.logi);


        emai=(EditText)findViewById(R.id.mail);
        pass=(EditText)findViewById(R.id.mail);


    }
    boolean f=false;
    void okk(){
        if(!f){
            Toast.makeText(login.this, "Email or pass is wrong", Toast.LENGTH_LONG).show();

        }

    }

    String[] fa = {"Voter", "Candidate"};
    String T ="Like ";//voter
    //
    DatabaseReference FM = FirebaseDatabase.getInstance().getReference("Database").child("voter2");
    DatabaseReference FM2 =FirebaseDatabase.getInstance().getReference("Database").child("candidate");
    public void reg(View view) {

        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(T);
        builder.setItems(fa, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                if(which==0){
                    Intent i = new Intent(getBaseContext(), voter_new_acount.class);


                    startActivity(i);
                    finish();
                }
                if(which==1){
                    Intent i = new Intent(getBaseContext(), Main_Screen_candidate.class);

                    i.putExtra("t", 2);
                    startActivity(i);
                    finish();

                }
            }
        });
        builder.show();
    }
void DATAOK(int a, final voter_class v, final candidate_class c){
        if(a==1){

                final View dialogView = View.inflate(login.this, R.layout.conferm, null);
                final AlertDialog alertDialog = new AlertDialog.Builder(login.this).create();
               TextView aa=dialogView.findViewById(R.id.asds);
               aa.setText(aa.getText()+" "+v.getPhone()+ " this your phone number");
                Button bb= dialogView.findViewById(R.id.buttonConfirm);
                final EditText id_s=dialogView.findViewById(R.id.i_s);
                final EditText ph=dialogView.findViewById(R.id.i_p);
                Button bb2= dialogView.findViewById(R.id.buttonConfirm2);
                bb2 .setOnClickListener(new View.OnClickListener() {

                    public void onClick(View view) {
                        id_s.setVisibility(View.VISIBLE);

                        if(id_s.getText().toString().equals(v.secret)){
                            ph.setVisibility(View.VISIBLE);
                            v.secret=ph.getText().toString();
                            Intent intent = new Intent(login.this, Sms_input.class);
                            intent.putExtra("t", 4);
                            intent.putExtra("o", v);
                            startActivity(intent);
                            f=true;
                            finish();
                            alertDialog.dismiss();

                        }
                        else {
                            Toast.makeText(login.this, " Wrong", Toast.LENGTH_LONG).show();
                        }

                    }});
                bb. setOnClickListener(new View.OnClickListener() {

                    public void onClick(View view) {
                        Intent intent = new Intent(login.this, Sms_input.class);
                        intent.putExtra("t", 4);
                        intent.putExtra("o", v);
                        startActivity(intent);
                        f=true;
                        finish();
                        alertDialog.dismiss();

                    }});
                alertDialog.setView(dialogView);
                alertDialog.show();



        }
        if(a==2){
            final View dialogView = View.inflate(login.this, R.layout.conferm, null);
            final AlertDialog alertDialog = new AlertDialog.Builder(login.this).create();
            TextView aa=dialogView.findViewById(R.id.asds);
            aa.setText(aa.getText()+" "+v.getPhone()+ " this your phone number");
            final EditText id_s=dialogView.findViewById(R.id.i_s);
            final EditText ph=dialogView.findViewById(R.id.i_p);
            Button bb= dialogView.findViewById(R.id.buttonConfirm);
            Button bb2= dialogView.findViewById(R.id.buttonConfirm2);
            bb2 .setOnClickListener(new View.OnClickListener() {

                public void onClick(View view) {
                    id_s.setVisibility(View.VISIBLE);

                    if(id_s.getText().toString().equals(c.secret)){
                        ph.setVisibility(View.VISIBLE);
                        c.secret=ph.getText().toString();
                        Intent intent = new Intent(login.this, Sms_input.class);
                        intent.putExtra("t", 4);
                        intent.putExtra("o", c);
                        startActivity(intent);
                        f=true;
                        finish();
                        alertDialog.dismiss();

                    }
                    else {
                        Toast.makeText(login.this, " Wrong", Toast.LENGTH_LONG).show();
                    }
                }});
            bb. setOnClickListener(new View.OnClickListener() {

                public void onClick(View view) {
                    Intent intent = new Intent(login.this, Sms_input.class);
                    intent.putExtra("t", 3);
                    intent.putExtra("o", c);

                    startActivity(intent);
                    f=true;
                    finish();
                    alertDialog.dismiss();

                }});
            alertDialog.setView(dialogView);
            alertDialog.show();
        }

}
    public void log(View view) {



        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(T);
        builder.setItems(fa, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                if(which==0){
                    FM.addListenerForSingleValueEvent(new ValueEventListener() {
                        @Override
                        public void onDataChange(DataSnapshot snapshot) {
                            for (DataSnapshot childSnapshot : snapshot.getChildren()) {
                                voter_class u=  childSnapshot.getValue(voter_class.class);
                                if(u.mail.equalsIgnoreCase(emai.getText().toString().trim())){
                                    if(u.pass.equals(pass.getText().toString().trim())) {
                                        DATAOK(1, u, null);
                                    }
                                }


                            }
                            okk();

                        }

                        @Override
                        public void onCancelled(DatabaseError databaseError) {

                        }
                    });
                }
                if(which==1){
                    FM2.addListenerForSingleValueEvent(new ValueEventListener() {
                        @Override
                        public void onDataChange(DataSnapshot snapshot) {
                            for (DataSnapshot childSnapshot : snapshot.getChildren()) {
                                candidate_class u=  childSnapshot.getValue(candidate_class.class);

                                if(u.mail.equalsIgnoreCase(emai.getText().toString().trim())){
                                    if(u.pass.equals(pass.getText().toString().trim())) {

                                      DATAOK(2, null, u);

                                    }}

                            }
                            okk();

                        }

                        @Override
                        public void onCancelled(DatabaseError databaseError) {

                        }
                    });
                }
            }
        });
        builder.show();
    }
}
