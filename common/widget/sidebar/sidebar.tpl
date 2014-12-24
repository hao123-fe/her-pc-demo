{%define%}
<a id="btn-navbar" class="btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
    <span class="icon-bar"></span>
</a>
{%widget name="common:widget/nav/nav.tpl"%}
{%require name="home:static/lib/js/jquery-1.10.1.js"%}
{%script%}
    $('.btn-navbar').click(function() {
        require.defer(['./sidebar.async.js'], function(sidebar){
            sidebar.run();
        });
    });
{%/script%}
{%/define%}