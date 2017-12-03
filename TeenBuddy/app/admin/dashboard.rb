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
        panel "Top 10 Teenagers" do
          table_for Client.all.sort_by(&:get_total_post_counts).last(10).reverse.each do |client|
            column("Name")    { |client| link_to(client.client_name, admin_client_path(client)) }
            column("Posts")    { |client|client.get_total_post_counts }
            column ("Paid")     { |client| number_to_currency  client.get_total_post_paid }
            column("Avg Rating")    { |client| "#{client.get_average_rating.round(1)} / 5" }

          end   #table
        
        end #panel
    end #column
    end # columns

    columns do
      column do
        div do
          br
          text_node %{<iframe src="https://rpm.newrelic.com/public/charts/6VooNO2hKWB"
                              width="500" height="300" scrolling="no" frameborder="no">
                      </iframe>}.html_safe
        end
      end

      column do
        panel "ActiveAdmin Demo" do
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
