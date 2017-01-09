module ApplicationHelper
  def full_title page_title
    base_title = t("project_name")
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def status_select
    SuggestProduct.all.map{|request| [request.status, request.status]}
  end

  def category_select
    Category.all.map{|category| [category.name, category.id]}
  end

  def group_by_order
    column_chart Order.group(:created_at).count,
      height: '500px', library: {
      title: {text: 'Data Order', x: -10},
      yAxis: {
        allowDecimals: false,
        title: {
          text: 'Count Order'
        }
      },
      xAxis: {
        title: {
        text: 'Orders'
        }
      }
    }
  end

  def group_by_user
    column_chart User.group_by_day(:created_at).count,
      height: '500px', library: {
      title: {text: 'Data User', x: -10},
      yAxis: {
        allowDecimals: false,
        title: {
          text: 'Count User'
        }
      },
      xAxis: {
        title: {
        text: 'Users'
        }
      }
    }
  end
end
