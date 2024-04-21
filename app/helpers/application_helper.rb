module ApplicationHelper
  def sortable_table_header(title, column, path_method, **)
    content_tag(:th, class: "th") do
      sortable_column(title, column, path_method)
    end
  end

  def sortable_column(title, column, path_method, **)
    direction = (column.to_s == params[:sort].to_s && params[:direction] == "asc") ? "desc" : "asc"

    query_params = request.query_parameters.merge(sort: column, direction: direction)

    path = send(path_method, query_params)
    link_to(path, class: "th-link", **) do
      concat title
      concat sort_icon(column)
    end
  end

  def sort_icon(column)
    return unless params[:sort].to_s == column.to_s

    if params[:direction] == "asc"
      content_tag(:i, nil, class: 'bi bi-arrow-up-short')
    else
      content_tag(:i, nil, class: 'bi bi-arrow-down-short')
    end
  end

end
