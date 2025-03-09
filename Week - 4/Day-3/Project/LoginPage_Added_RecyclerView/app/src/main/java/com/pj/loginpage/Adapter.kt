package com.pj.loginpage

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView


class UserAdapter(private val itemList: ArrayList<User>) : RecyclerView.Adapter<UserAdapter.ItemViewHolder>() {
    class ItemViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val nameText: TextView = itemView.findViewById(R.id.userName)
        val emailText: TextView = itemView.findViewById(R.id.userEmail)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {

        val viewLayout = LayoutInflater.from(parent.context).inflate(R.layout.user_details, parent, false)
        return ItemViewHolder(viewLayout)
    }

    override fun getItemCount(): Int {
        return itemList.size
    }

    override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
        val currentUser = itemList[position]
        holder.nameText.text = currentUser.uName
        holder.emailText.text = currentUser.uEmail
    }
}
