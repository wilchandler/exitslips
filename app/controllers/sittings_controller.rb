class SittingsController < ApplicationController
  def create
    @sitting = Sitting.new
  end
end

# <form action="/answers/create" method="post">
#     <% @quiz.questions.each do |q| %>
#       <h4><%= q.query %></h4>
#     <% q.options.each do |o| %>
#       <input type="radio" name="<%= q.id %>" value="<%= o.id%>"><%= o.content %>
#     <% end %>
#     <% end %>
#     <p><input type="submit" value="submit"></p>
# </form>


# <form action="/quizzes/:quiz_id/sittings" method="post">
#      <% @quiz.questions.each do |q| %>
#        <h4><%= q.query %></h4>
#      <% q.options.each do |o| %>
#        <input type="radio" name="<%= q.id %>" value="<%= o.id%>"><%= o.content %>
#        <input type="hidden" name="<%=@sitting.quiz_id%>", value="@quiz.id">
#      <% end %>
#      <% end %>
#      <p><input type="submit" value="submit"></p>
# </form>
