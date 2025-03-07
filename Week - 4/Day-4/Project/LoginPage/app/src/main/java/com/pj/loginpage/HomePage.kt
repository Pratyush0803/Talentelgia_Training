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
        itemList.add(User("Pratyush", "pratyush@gmail.com", "+919564758856"))
        itemList.add(User("Alice", "alice@gmail.com", "+917898789987"))
        itemList.add(User("Bob", "bob@gmail.com", "+919876543210"))
        itemList.add(User("Charlie", "charlie@gmail.com", "+916551234567"))
        itemList.add(User("David", "david@gmail.com", "+917112223333"))
        itemList.add(User("Eve", "eve@gmail.com", "+919445556666"))
        itemList.add(User("Frank", "frank@gmail.com", "+919778889999"))
        itemList.add(User("Grace", "grace@gmail.com", "+91012023030"))
        itemList.add(User("Hannah", "hannah@gmail.com", "+917216549870"))
        itemList.add(User("Ivy", "ivy@gmail.com", "+919098087070"))
        itemList.add(User("Jack", "jack@gmail.com", "+918213234343"))
        itemList.add(User("Katie", "katie@gmail.com", "+917545656767"))
        itemList.add(User("Liam", "liam@gmail.com", "+917878989090"))
        itemList.add(User("Mia", "mia@gmail.com", "+918122334455"))
        itemList.add(User("Noah", "noah@gmail.com", "+917656767878"))
        itemList.add(User("Olivia", "olivia@gmail.com", "+918989090101"))
        itemList.add(User("Peter", "peter@gmail.com", "+919010203030"))
        itemList.add(User("Quinn", "quinn@gmail.com", "+919434545656"))
        itemList.add(User("Ryan", "ryan@gmail.com", "+916767878989"))
        itemList.add(User("Sophia", "sophia@gmail.com", "+919091212323"))

    }
}