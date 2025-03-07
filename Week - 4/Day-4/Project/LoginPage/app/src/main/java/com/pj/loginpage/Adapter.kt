package com.pj.loginpage

import android.content.Intent
import android.net.Uri
import android.view.LayoutInflater
import android.view.View
import android.view.View.OnClickListener
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.widget.SearchView.OnCloseListener
import androidx.recyclerview.widget.RecyclerView
import androidx.core.net.toUri
import org.w3c.dom.Text

class UserAdapter(private val itemList: ArrayList<User>) : RecyclerView.Adapter<UserAdapter.ItemViewHolder>() {
    class ItemViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val nameText: TextView = itemView.findViewById(R.id.userName)
        var emailText: TextView = itemView.findViewById(R.id.userEmail)
        var phoneText: TextView = itemView.findViewById(R.id.userPhone)
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
        holder.phoneText.text = currentUser.uPhone

        holder.emailText.setOnClickListener{
            val intent = Intent(Intent.ACTION_VIEW, "mailto:${currentUser.uEmail}".toUri())
            holder.itemView.context.startActivity(intent)
        }

        holder.phoneText.setOnClickListener{
            val intent = Intent(Intent.ACTION_VIEW, "tel:${currentUser.uPhone}".toUri())
            holder.itemView.context.startActivity(intent)
        }

    }

}
