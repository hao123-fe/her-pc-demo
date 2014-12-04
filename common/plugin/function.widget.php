<?php
/** 
 *           File:  function.widget.php
 *           Path:  src/plugin
 *         Author:  zhangyuanwei
 *       Modifier:  zhangyuanwei
 *       Modified:  2012-05-02 12:48:53  
 *    Description:  
 *      Copyright:  (c) 2011 All Rights Reserved
 */

function smarty_function_widget($params, $template)
{
    $name = $params['name'];
    $method = $params['method'];

    BigPipeResource::registModule($name, true);
    
    $path = BigPipeResource::getFisResourceByPath($name);

    // 添加widget依赖的css和less
    if(!empty($path["deps"])){

        $deps = $path["deps"];
        $context   = BigPipe::currentContext();

        foreach($deps as $dep){
            BigPipeResource::registModule($dep);

            $ext = substr(strrchr($dep, "."), 1);
            switch ($ext) {
                case 'css':
                case 'less':
                    $on = 'beforedisplay';
                    $context->addRequire($on, $dep);
                    break;
            }
        }
    }

    $smarty=$template->smarty;
    $tplpath = $path["uri"];

    $fn='smarty_template_function_' . $method;
    if(!function_exists($fn)) {
        try {
            $smarty->fetch($tplpath);
        } catch (Exception $e) {
            
        }
    }

    if(function_exists($fn)) {
        unset($params['name']);
        if(!isset($params["id"])){
            //$params["id"] = BigPipe::getController()->sessionUniqId("__wgt_");
        }
        return $fn($template, $params);
    } else {
        throw new Exception("Undefined function \"$method\" in \"$name\" @ \"$tplpath\"");
        //echo "模板\"$name\"中未定义函数\"$method\"@\"$tplpath\"";
    }
}

