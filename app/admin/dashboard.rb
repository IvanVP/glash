ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
      
    end
    div class: "blank_slate_container", id: "users" do
      span class: "blank_slate" do
        span "Тест"
        small "Tect1"
      end
      
    end

    

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      # column do
      #   panel "Пользователи" do
      #     ul do
      #       User.all.map do |user|
      #         li link_to(user.fullname, admin_user_path(user))
      #       end
      #     end
      #   end
      # end

      column do
        panel "New Users - last.week " do
          ul do
            "Всего за последнюю неделю - #{User.where("created_at > ?", 1.week.ago).count }"
          end
          ul do
            User.where("created_at > ?", 1.week.ago).map do |user|
              li link_to(user.fullname, admin_user_path(user))
            end
          end
        end
      end
      column do
        panel "Администраторы" do
          ul do
            User.all.map do |user|
              li link_to(user.fullname, admin_user_path(user)) if user.is_admin?
            end
          end
        end
      end
      column do
        panel "Сейчас на сайте" do
          ul do
            User.all.map do |user|
              li link_to(user.fullname, admin_user_path(user)) if user.current_sign_in_at
            end
          end
        end
      end

      # column do
      #   panel "Пользователи" do
      #     ul do
      #       Post.recent(5).map do |post|
      #         li link_to(post.title, admin_post_path(post))
      #       end
      #     end
      #   end
      # end

      column do
        panel "Информация" do
          para "Welcome to ActiveAdmin."
        end
      end
    end
  end # content
end
