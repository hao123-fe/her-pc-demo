{%extends file="common/page/layout.tpl"%}
{%block name="block_head_static"%}
    <!--[if lt IE 9]>
        <script src="/lib/js/html5.js"></script>
    <![endif]-->
    {%* 模板中加载静态资源 *%}
    {%require name="home:static/lib/css/bootstrap.css"%}
    {%require name="home:static/lib/css/bootstrap-responsive.css"%}
    {%require name="home:static/lib/js/jquery-1.10.1.js"%}
{%/block%}
{%block name="content"%}

    <div id="wrapper">
        {%pagelet id="sidebar"%}
            {%$nav_index = $smarty.get.nav|default:0%}
            {%* 通过widget插件加载模块化页面片段，name属性对应文件路径,模块名:文件目录路径 *%}
            {%widget
                name="common:widget/sidebar/sidebar.tpl"
                data=$docs
            %}
        {%/pagelet%}

        {%pagelet id="container"%}
            {%$nav_index = $smarty.get.nav|default:0%}
            {%$doc = $docs[$nav_index]%}
            
            <a id="forkme_banner" target="_blank" href="{%$github%}">View on GitHub</a>
            
            {%if $nav_index == 0%}
                {%widget name="home:widget/slogan/slogan.tpl"%}
            {%/if%}

            {%*foreach $docs as $index=>$doc*%}
                {%widget
                    name="home:widget/section/section.tpl"
                    method="section"
                    doc=$doc.doc index=$nav_index
                %}
            {%*/foreach*%}
        {%/pagelet%}
    </div>
    {%require name="home:static/index/index.less"%}

    {%* 通过script插件收集JS片段 *%}
    {%script%}
        {%* 启用emulator监控页面点击实现局部刷新 *%}
        {%* require.defer会在DomReady之后执行 *%}
        require.defer(["home:widget/js-helper/pageEmulator.js"],function(emulator){
            emulator.start();
        });
    {%/script%}

    {%script%}
        var _hmt = _hmt || [];
        (function() {
          var hm = document.createElement("script");
          hm.src = "//hm.baidu.com/hm.js?ab6cd754962e109e24b0bcef3f05c34f";
          var s = document.getElementsByTagName("script")[0]; 
          s.parentNode.insertBefore(hm, s);
        })();
    {%/script%}
{%/block%}