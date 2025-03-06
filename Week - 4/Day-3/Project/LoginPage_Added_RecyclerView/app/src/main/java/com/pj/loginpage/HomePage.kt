package com.pj.loginpage

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.recyclerview.widget.LinearLayoutManager
import com.pj.loginpage.databinding.ActivityHomePageBinding

class HomePage : AppCompatActivity() {
    private lateinit var itemList: ArrayList<User>
    private lateinit var userAdapter : UserAdapter
    private lateinit var binding: ActivityHomePageBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        binding = ActivityHomePageBinding.inflate(layoutInflater)
        enableEdgeToEdge()
        super.onCreate(savedInstanceState)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        itemList = ArrayList()
        userListItems()
        userAdapter = UserAdapter(itemList)
        binding.recyclerView.layoutManager = LinearLayoutManager(this)
        binding.recyclerView.setHasFixedSize(true)
        binding.recyclerView.adapter = userAdapter

    }
    private fun userListItems(){
        itemList.add(User("Pratyush","pratyush@gmail.com"))
        itemList.add(User("Swagat","swagat@gmail.com"))
        itemList.add(User("Tejaswini","tejaswini@gmail.com"))
        itemList.add(User("Mamata","mamata@gmail.com"))
        itemList.add(User("Gadadhar","gadadhar@gmail.com"))
    }
}