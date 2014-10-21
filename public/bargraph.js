
var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width = 500 - margin.left - margin.right,
    height = 250 - margin.top - margin.bottom;

var formatPercent = d3.format(".0%");

var x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1, 1);

var y = d3.scale.linear()
    .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .tickFormat(formatPercent);

var svg = d3.select("#mastery_by_section").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var data = [
    {letter: "A", balance: 67},
    {letter: "B", balance: 92},
    {letter: "C", balance: 80},
    {letter: "D", balance: 53},
    {letter: "E", balance: 02},
    {letter: "F", balance: 88},
    {letter: "G", balance: 22},
    {letter: "H", balance: 94},
    {letter: "I", balance: 73},
    {letter: "J", balance: 53},
    {letter: "K", balance: 47},
    {letter: "L", balance: 25},
    {letter: "M", balance: 17},
    {letter: "N", balance: 49},
    {letter: "O", balance: 07},
    {letter: "P", balance: 29},
    {letter: "Q", balance: 98},
    {letter: "R", balance: 87},
    {letter: "S", balance: 33},
    {letter: "T", balance: 56},
    {letter: "U", balance: 58},
    {letter: "V", balance: 37},
    {letter: "W", balance: 65},
    {letter: "X", balance: 50},
    {letter: "Y", balance: 71},
    {letter: "Z", balance: 74}
    ]

  x.domain(data.map(function(d) { return d.letter; }));
  y.domain([0, d3.max(data, function(d) { return d.balance; })]);

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("balance");

  svg.selectAll(".bar")
      .data(data)
    .enter().append("rect")
      .attr("class", "bar")
      .attr("x", function(d) { return x(d.letter); })
      .attr("width", x.rangeBand())
      .attr("y", function(d) { return y(d.balance); })
      .attr("height", function(d) { return height - y(d.balance);

  d3.select("input").on("change", change);

  var sortTimeout = setTimeout(function() {
    d3.select("input").property("checked", true).each(change);
  }, 2000);

    function change() {
      clearTimeout(sortTimeout);

      // Copy-on-write since tweens are evaluated after a delay.
      var x0 = x.domain(data.sort(this.checked
          ? function(a, b) { return b.balance - a.balance; }
          : function(a, b) { return d3.ascending(a.letter, b.letter); })
          .map(function(d) { return d.letter; }))
          .copy();

      var transition = svg.transition().duration(750),
          delay = function(d, i) { return i * 50; };

      transition.selectAll(".bar")
          .delay(delay)
          .attr("x", function(d) { return x0(d.letter); });

      transition.select(".x.axis")
          .call(xAxis)
        .selectAll("g")
          .delay(delay);
    }
  });










