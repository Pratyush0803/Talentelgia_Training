package com.pj.loginpage

import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.os.Bundle
import android.widget.EditText
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.AppCompatButton
import androidx.coordinatorlayout.widget.CoordinatorLayout
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.google.android.material.snackbar.Snackbar

class LoginPage : AppCompatActivity() {
    private var btnLogin:AppCompatButton? = null
    private var edtSEmail:EditText? = null
    private var edtSPassword:EditText? = null
    private lateinit var layout2:CoordinatorLayout
    private var txtSignUp:TextView? = null

    private var storedEmail = ""
    private var storedPassword = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_login_page)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main2)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        edtSEmail = findViewById(R.id.edt_LogIn_Email)
        edtSPassword = findViewById(R.id.edt_LogIn_Password)
        btnLogin = findViewById(R.id.btn_LogIn)
        layout2 = findViewById(R.id.main2)
        txtSignUp = findViewById(R.id.txt_Btn_SignUp)

        val sharedPreferences: SharedPreferences = getSharedPreferences("My_User_Data", Context.MODE_PRIVATE)
//    storedEmail= intent.getStringExtra("email_key")?:""
//     storedPassword = intent.getStringExtra("pass_key")?:""

        storedEmail = sharedPreferences.getString("email_key",storedEmail)?:""
        storedPassword = sharedPreferences.getString("pass_key",storedPassword)?:""
        btnLogin?.setOnClickListener{
            if (myData()){
                val intent = Intent(this,HomePage::class.java)
                startActivity(intent)
                finish()
            }
        }
        txtSignUp?.setOnClickListener{
            val i = Intent(this,MainActivity::class.java)
            startActivity(i)
            finish()
        }
    }
    private fun myData():Boolean{
        if (edtSEmail?.text.toString().isEmpty()){
            Snackbar.make(layout2, "Enter your Email.", Snackbar.LENGTH_SHORT).show()
            return false
        }else if (edtSEmail?.text.toString() != storedEmail) {
            Snackbar.make(layout2, "Incorrect Email.", Snackbar.LENGTH_SHORT).show()
            return false
        }
        if (edtSPassword?.text.toString().isEmpty()) {
            Snackbar.make(layout2, "Enter your Password.", Snackbar.LENGTH_SHORT).show()
            return false
        }else if (edtSPassword?.text.toString() != storedPassword) {
            Snackbar.make(layout2, "Incorrect Password.", Snackbar.LENGTH_SHORT).show()
            return false
        }
        return true
    }
}