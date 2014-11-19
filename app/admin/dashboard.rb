ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    div class: "blank_slate_container", id: "ideas" do
      published_ideas = Idea.published
      published_ideas.each do |idea|
        div class: "actadm_dashboard" do
          span class: "blank_slate" do
            div :for => idea do
              h5 link_to idea.title, admin_idea_path(idea) 
              div class: "user" do
                link_to idea.user.fullname, admin_user_path(idea.user)
              end
              div do
                link_to admin_idea_path(idea) do
                  image_tag (image_for_idea(idea)),  title: idea.title
                end
              end
              div class: "synopsis" do
                simple_format idea.synopsis
              end
            end
          end
        end
      end
      
    end

    # div class: "blank_slate_container", id: "users" do
    #   span class: "blank_slate" do
    #     span "Тест"
    #     small "Tect1"
    #   end
      
    # end

    

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
        panel "Идеи, ожидающие модерации" do
          ul do
            Idea.published.map do |idea|
              li link_to(idea.title, admin_idea_path(idea))
            end
          end
        end
      end

      column do
        panel "Новые пользователи (за последнюю неделю) " do
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
        panel "Сейчас на сайте" do
          ul do
            User.all.map do |user|
              li link_to(user.fullname, admin_user_path(user)) if user.current_sign_in_at
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

      # column do
      #   panel "Пользователи" do
      #     ul do
      #       Post.recent(5).map do |post|
      #         li link_to(post.title, admin_post_path(post))
      #       end
      #     end
      #   end
      # end

      # column do
      #   panel "Информация" do
      #     para "Welcome to ActiveAdmin."
      #   end
      # end
    end
  end # content
end
