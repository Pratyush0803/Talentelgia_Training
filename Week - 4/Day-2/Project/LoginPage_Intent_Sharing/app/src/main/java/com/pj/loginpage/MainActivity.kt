package com.pj.loginpage

import android.content.Intent
import android.os.Bundle
import android.widget.EditText
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.AppCompatButton
import androidx.coordinatorlayout.widget.CoordinatorLayout
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.google.android.material.snackbar.Snackbar

class MainActivity : AppCompatActivity() {
    private var btnSignUp: AppCompatButton? = null

    private var edtName: EditText? = null
    private var edtEmail :EditText? = null
    private var edtPhone :EditText? = null
    private var edtPassword:EditText? = null
    private lateinit var layout : CoordinatorLayout

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

        layout = findViewById(R.id.main)

        btnSignUp?.setOnClickListener{
            if (checkAllFields()){
                    val intent = Intent(applicationContext,LoginPage::class.java)
                intent.putExtra("email_key",edtEmail?.text.toString())
                intent.putExtra("pass_key",edtPassword?.text.toString())
                    startActivity(intent)
            }
        }
    }

    private fun checkAllFields():Boolean{
        val namePattern = "^[a-zA-Z]{3,}( {1,2}[a-zA-Z]{3,})*$"

        val emailPattern = "^[a-z0-9]+(?:[._-][a-z0-9]+)*@[a-z0-9]+(?:[-.][a-z0-9]+)*\\.[a-z]{2,}$"

        val phonePattern = "^(\\+91[\\-\\s]?)?0?(91)?[6789]\\d{9}$"

        val passwordPattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+\$).{8,}$"

        if (!Regex(namePattern).matches(edtName?.text.toString())){
            Snackbar.make(layout,"Please enter a valid Name.",Snackbar.LENGTH_SHORT).show()

            return false
        }

        if (!Regex(emailPattern).matches(edtEmail?.text.toString())){
            Snackbar.make(layout,"Enter a valid Email",Snackbar.LENGTH_SHORT).show()
            return false
        }

        if (!Regex(phonePattern).matches(edtPhone?.text.toString())){
            Snackbar.make(layout,"Please enter a valid Phone No.",Snackbar.LENGTH_SHORT).show()
            return false
        }

        if (!Regex(passwordPattern).matches(edtPassword?.text.toString())){
            Snackbar.make(layout,"Passwords must be at least 8 characters and include uppercase, lowercase, a number, and a special character.",Snackbar.LENGTH_SHORT).show()
            return false
        }
        return true
    }
}