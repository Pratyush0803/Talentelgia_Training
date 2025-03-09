package com.pj.loginpage

import android.content.Intent
import android.os.Bundle
import android.view.View
import android.view.View.OnClickListener
import android.widget.Button
import android.widget.EditText
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.AppCompatButton
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

class MainActivity : AppCompatActivity() {
    var btnSignUp: AppCompatButton? = null

    var edtName: EditText? = null
    var edtEmail :EditText? = null
    var edtPhone :EditText? = null
    var edtPassword:EditText? = null

    var isAllFieldChecked = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        btnSignUp = findViewById(R.id.btn_SignUp)
        edtName = findViewById(R.id.edt_Name)
        edtEmail = findViewById(R.id.edt_Email)
        edtPhone = findViewById(R.id.edt_Phone_No)
        edtPassword = findViewById(R.id.edt_Password)


//        val buttonSignUp: Button =  findViewById(R.id.btn_SignUp)
//        buttonSignUp.setOnClickListener{
//            val intent = Intent(this,Login_Page::class.java)
//            startActivity(intent)
//        }
    }
}