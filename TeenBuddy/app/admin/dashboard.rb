ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    #div class: "blank_slate_container", id: "dashboard_default_message" do
     # span class: "blank_slate" do
      #  span I18n.t("active_admin.dashboard_welcome.welcome")
       # small I18n.t("active_admin.dashboard_welcome.call_to_action")
      #end
    #end

    columns do
      column do
        panel "Average Salary" do
          div do
           # category_hash = []
            #Post.all.group(:service_category_id).count(:id).each {|category| category_hash.push([ServiceCategory.find(category.first).title, category.second.to_s]) }   
            #Post.all.group(:status).count
            category_hash = []

           Post.all.group(:service_category_id).average(:pay).each{
            |category|
            category_hash.push([ServiceCategory.find(category.first).title, category.second.to_s])
          }

         # .average(:pay)
        column_chart  category_hash ,label: "Avg Salary",xtitle: "Job Category", ytitle: "Average Pay" 
         #bar_chart Teenager.group(:service_category).limit(5) ,{library: {title:'Top 5 Downloads'}}
         #column_chart [["2016-01-01", 30], ["2016-02-01", 54]], stacked: true, library: {colors: ["#D80A5B", "#21C8A9", "#F39C12", "#A4C400"]}
        end
        end
      end

      column do
        panel "Job Category Distribution" do
          div do

            category_hash = []

            Post.all.group(:service_category_id).count(:id).each {|category| category_hash.push([ServiceCategory.find(category.first).title, category.second.to_s]) }   
            pie_chart category_hash
            
         #bar_chart Teenager.group(:service_category).limit(5) ,{library: {title:'Top 5 Downloads'}}
         #column_chart [["2016-01-01", 30], ["2016-02-01", 54]], stacked: true, library: {colors: ["#D80A5B", "#21C8A9", "#F39C12", "#A4C400"]}
        end
        end
      end 

    end # columns


    columns do
         column do
        panel "Teenager Interests" do
         div do

            category_hash = []

            TeenagerInterest.all.group(:service_category_id).count(:id).each {|category| category_hash.push([ServiceCategory.find(category.first).title, category.second.to_s]) }   
            pie_chart category_hash
        end
        end #panel
    end #column
      column do
        panel "Operational Status" do
        attributes_table_for Client do
            row("Total Profit")  { number_to_currency Transaction.getTotalProfit }
            row ("Total Transactions")  {Transaction.all.count}
            row("Total Teenagers")  {  Teenager.all.count }
            row("Total Clients")  {  Client.all.count }
            row ("Total Posts")  {Post.all.count}
            row ("Total Application"){Service.all.where(:status =>[:applied]).count}
            row ("Total Job Done"){Service.all.where(:status =>[:finished]).count}

            # row("Dollar Value"){ number_to_currency LineItem.where(:product_id => resource.id).sum(:price) }
             end
        
        end #panel
    end #column
    
    end #columns

      columns do
     column do
        panel "Top 10 Teenagers" do
          table_for Teenager.all.sort_by(&:get_all_service_numbers).last(10).reverse.each do |teenager|
            column("Name")    { |teenager| link_to(teenager.teenager_name, admin_teenager_path(teenager)) }
            column("Services")    { |teenager|teenager.get_all_service_numbers }
            column ("Earned")     { |teenager| number_to_currency  teenager.get_total_paid }
            column("Avg Rating")    { |teenager| "#{teenager.get_average_rating_round} / 5" }

          end   #table
        
        end #panel
    end #column

        column do
        panel "Top 10 Clients" do
          table_for Client.all.sort_by(&:get_total_post_counts).last(10).reverse.each do |client|
            column("Name")    { |client| link_to(client.client_name, admin_client_path(client)) }
            column("Posts")    { |client|client.get_total_post_counts }
            column ("Paid")     { |client| number_to_currency  client.get_total_post_paid }
            column("Avg Rating")    { |client| "#{client.get_average_rating.round(1)} / 5" }

          end   #table
        
        end #panel
    end #column
    end # columns




    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
