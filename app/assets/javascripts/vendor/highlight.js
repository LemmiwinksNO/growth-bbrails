// Apply highlighting to pre.code (search to find and change it)
var hljs=new function(){function k(v){return v.replace(/&/gm,"&amp;").replace(/</gm,"&lt;").replace(/>/gm,"&gt;")}function t(v){return v.nodeName.toLowerCase()}function i(w,x){var v=w&&w.exec(x);return v&&v.index==0}function d(v){return Array.prototype.map.call(v.childNodes,function(w){if(w.nodeType==3){return b.useBR?w.nodeValue.replace(/\n/g,""):w.nodeValue}if(t(w)=="br"){return"\n"}return d(w)}).join("")}function r(w){var v=(w.className+" "+(w.parentNode?w.parentNode.className:"")).split(/\s+/);v=v.map(function(x){return x.replace(/^language-/,"")});return v.filter(function(x){return j(x)||x=="no-highlight"})[0]}function o(x,y){var v={};for(var w in x){v[w]=x[w]}if(y){for(var w in y){v[w]=y[w]}}return v}function u(x){var v=[];(function w(y,z){for(var A=y.firstChild;A;A=A.nextSibling){if(A.nodeType==3){z+=A.nodeValue.length}else{if(t(A)=="br"){z+=1}else{if(A.nodeType==1){v.push({event:"start",offset:z,node:A});z=w(A,z);v.push({event:"stop",offset:z,node:A})}}}}return z})(x,0);return v}function q(w,y,C){var x=0;var F="";var z=[];function B(){if(!w.length||!y.length){return w.length?w:y}if(w[0].offset!=y[0].offset){return(w[0].offset<y[0].offset)?w:y}return y[0].event=="start"?w:y}function A(H){function G(I){return" "+I.nodeName+'="'+k(I.value)+'"'}F+="<"+t(H)+Array.prototype.map.call(H.attributes,G).join("")+">"}function E(G){F+="</"+t(G)+">"}function v(G){(G.event=="start"?A:E)(G.node)}while(w.length||y.length){var D=B();F+=k(C.substr(x,D[0].offset-x));x=D[0].offset;if(D==w){z.reverse().forEach(E);do{v(D.splice(0,1)[0]);D=B()}while(D==w&&D.length&&D[0].offset==x);z.reverse().forEach(A)}else{if(D[0].event=="start"){z.push(D[0].node)}else{z.pop()}v(D.splice(0,1)[0])}}return F+k(C.substr(x))}function m(y){function v(z){return(z&&z.source)||z}function w(A,z){return RegExp(v(A),"m"+(y.cI?"i":"")+(z?"g":""))}function x(D,C){if(D.compiled){return}D.compiled=true;D.k=D.k||D.bK;if(D.k){var z={};function E(G,F){if(y.cI){F=F.toLowerCase()}F.split(" ").forEach(function(H){var I=H.split("|");z[I[0]]=[G,I[1]?Number(I[1]):1]})}if(typeof D.k=="string"){E("keyword",D.k)}else{Object.keys(D.k).forEach(function(F){E(F,D.k[F])})}D.k=z}D.lR=w(D.l||/\b[A-Za-z0-9_]+\b/,true);if(C){if(D.bK){D.b=D.bK.split(" ").join("|")}if(!D.b){D.b=/\B|\b/}D.bR=w(D.b);if(!D.e&&!D.eW){D.e=/\B|\b/}if(D.e){D.eR=w(D.e)}D.tE=v(D.e)||"";if(D.eW&&C.tE){D.tE+=(D.e?"|":"")+C.tE}}if(D.i){D.iR=w(D.i)}if(D.r===undefined){D.r=1}if(!D.c){D.c=[]}var B=[];D.c.forEach(function(F){if(F.v){F.v.forEach(function(G){B.push(o(F,G))})}else{B.push(F=="self"?D:F)}});D.c=B;D.c.forEach(function(F){x(F,D)});if(D.starts){x(D.starts,C)}var A=D.c.map(function(F){return F.bK?"\\.?\\b("+F.b+")\\b\\.?":F.b}).concat([D.tE]).concat([D.i]).map(v).filter(Boolean);D.t=A.length?w(A.join("|"),true):{exec:function(F){return null}};D.continuation={}}x(y)}function c(S,L,J,R){function v(U,V){for(var T=0;T<V.c.length;T++){if(i(V.c[T].bR,U)){return V.c[T]}}}function z(U,T){if(i(U.eR,T)){return U}if(U.eW){return z(U.parent,T)}}function A(T,U){return !J&&i(U.iR,T)}function E(V,T){var U=M.cI?T[0].toLowerCase():T[0];return V.k.hasOwnProperty(U)&&V.k[U]}function w(Z,X,W,V){var T=V?"":b.classPrefix,U='<span class="'+T,Y=W?"":"</span>";U+=Z+'">';return U+X+Y}function N(){var U=k(C);if(!I.k){return U}var T="";var X=0;I.lR.lastIndex=0;var V=I.lR.exec(U);while(V){T+=U.substr(X,V.index-X);var W=E(I,V);if(W){H+=W[1];T+=w(W[0],V[0])}else{T+=V[0]}X=I.lR.lastIndex;V=I.lR.exec(U)}return T+U.substr(X)}function F(){if(I.sL&&!f[I.sL]){return k(C)}var T=I.sL?c(I.sL,C,true,I.continuation.top):g(C);if(I.r>0){H+=T.r}if(I.subLanguageMode=="continuous"){I.continuation.top=T.top}return w(T.language,T.value,false,true)}function Q(){return I.sL!==undefined?F():N()}function P(V,U){var T=V.cN?w(V.cN,"",true):"";if(V.rB){D+=T;C=""}else{if(V.eB){D+=k(U)+T;C=""}else{D+=T;C=U}}I=Object.create(V,{parent:{value:I}})}function G(T,X){C+=T;if(X===undefined){D+=Q();return 0}var V=v(X,I);if(V){D+=Q();P(V,X);return V.rB?0:X.length}var W=z(I,X);if(W){var U=I;if(!(U.rE||U.eE)){C+=X}D+=Q();do{if(I.cN){D+="</span>"}H+=I.r;I=I.parent}while(I!=W.parent);if(U.eE){D+=k(X)}C="";if(W.starts){P(W.starts,"")}return U.rE?0:X.length}if(A(X,I)){throw new Error('Illegal lexeme "'+X+'" for mode "'+(I.cN||"<unnamed>")+'"')}C+=X;return X.length||1}var M=j(S);if(!M){throw new Error('Unknown language: "'+S+'"')}m(M);var I=R||M;var D="";for(var K=I;K!=M;K=K.parent){if(K.cN){D=w(K.cN,D,true)}}var C="";var H=0;try{var B,y,x=0;while(true){I.t.lastIndex=x;B=I.t.exec(L);if(!B){break}y=G(L.substr(x,B.index-x),B[0]);x=B.index+y}G(L.substr(x));for(var K=I;K.parent;K=K.parent){if(K.cN){D+="</span>"}}return{r:H,value:D,language:S,top:I}}catch(O){if(O.message.indexOf("Illegal")!=-1){return{r:0,value:k(L)}}else{throw O}}}function g(y,x){x=x||b.languages||Object.keys(f);var v={r:0,value:k(y)};var w=v;x.forEach(function(z){if(!j(z)){return}var A=c(z,y,false);A.language=z;if(A.r>w.r){w=A}if(A.r>v.r){w=v;v=A}});if(w.language){v.second_best=w}return v}function h(v){if(b.tabReplace){v=v.replace(/^((<[^>]+>|\t)+)/gm,function(w,z,y,x){return z.replace(/\t/g,b.tabReplace)})}if(b.useBR){v=v.replace(/\n/g,"<br>")}return v}function p(z){var y=d(z);var A=r(z);if(A=="no-highlight"){return}var v=A?c(A,y,true):g(y);var w=u(z);if(w.length){var x=document.createElementNS("http://www.w3.org/1999/xhtml","pre");x.innerHTML=v.value;v.value=q(w,u(x),y)}v.value=h(v.value);z.innerHTML=v.value;z.className+=" hljs "+(!A&&v.language||"");z.result={language:v.language,re:v.r};if(v.second_best){z.second_best={language:v.second_best.language,re:v.second_best.r}}}var b={classPrefix:"hljs-",tabReplace:null,useBR:false,languages:undefined};function s(v){b=o(b,v)}function l(){if(l.called){return}l.called=true;var v=document.querySelectorAll("pre.code");Array.prototype.forEach.call(v,p)}function a(){addEventListener("DOMContentLoaded",l,false);addEventListener("load",l,false)}var f={};var n={};function e(v,x){var w=f[v]=x(this);if(w.aliases){w.aliases.forEach(function(y){n[y]=v})}}function j(v){return f[v]||f[n[v]]}this.highlight=c;this.highlightAuto=g;this.fixMarkup=h;this.highlightBlock=p;this.configure=s;this.initHighlighting=l;this.initHighlightingOnLoad=a;this.registerLanguage=e;this.getLanguage=j;this.inherit=o;this.IR="[a-zA-Z][a-zA-Z0-9_]*";this.UIR="[a-zA-Z_][a-zA-Z0-9_]*";this.NR="\\b\\d+(\\.\\d+)?";this.CNR="(\\b0[xX][a-fA-F0-9]+|(\\b\\d+(\\.\\d*)?|\\.\\d+)([eE][-+]?\\d+)?)";this.BNR="\\b(0b[01]+)";this.RSR="!|!=|!==|%|%=|&|&&|&=|\\*|\\*=|\\+|\\+=|,|-|-=|/=|/|:|;|<<|<<=|<=|<|===|==|=|>>>=|>>=|>=|>>>|>>|>|\\?|\\[|\\{|\\(|\\^|\\^=|\\||\\|=|\\|\\||~";this.BE={b:"\\\\[\\s\\S]",r:0};this.ASM={cN:"string",b:"'",e:"'",i:"\\n",c:[this.BE]};this.QSM={cN:"string",b:'"',e:'"',i:"\\n",c:[this.BE]};this.CLCM={cN:"comment",b:"//",e:"$"};this.CBLCLM={cN:"comment",b:"/\\*",e:"\\*/"};this.HCM={cN:"comment",b:"#",e:"$"};this.NM={cN:"number",b:this.NR,r:0};this.CNM={cN:"number",b:this.CNR,r:0};this.BNM={cN:"number",b:this.BNR,r:0};this.REGEXP_MODE={cN:"regexp",b:/\//,e:/\/[gim]*/,i:/\n/,c:[this.BE,{b:/\[/,e:/\]/,r:0,c:[this.BE]}]};this.TM={cN:"title",b:this.IR,r:0};this.UTM={cN:"title",b:this.UIR,r:0}}();hljs.registerLanguage("bash",function(b){var a={cN:"variable",v:[{b:/\$[\w\d#@][\w\d_]*/},{b:/\$\{(.*?)\}/}]};var d={cN:"string",b:/"/,e:/"/,c:[b.BE,a,{cN:"variable",b:/\$\(/,e:/\)/,c:[b.BE]}]};var c={cN:"string",b:/'/,e:/'/};return{l:/-?[a-z\.]+/,k:{keyword:"if then else elif fi for break continue while in do done exit return set declare case esac export exec",literal:"true false",built_in:"printf echo read cd pwd pushd popd dirs let eval unset typeset readonly getopts source shopt caller type hash bind help sudo",operator:"-ne -eq -lt -gt -f -d -e -s -l -a"},c:[{cN:"shebang",b:/^#![^\n]+sh\s*$/,r:10},{cN:"function",b:/\w[\w\d_]*\s*\(\s*\)\s*\{/,rB:true,c:[b.inherit(b.TM,{b:/\w[\w\d_]*/})],r:0},b.HCM,b.NM,d,c,a]}});hljs.registerLanguage("ruby",function(e){var h="[a-zA-Z_]\\w*[!?=]?|[-+~]\\@|<<|>>|=~|===?|<=>|[<>]=?|\\*\\*|[-/+%^&*~`|]|\\[\\]=?";var g="and false then defined module in return redo if BEGIN retry end for true self when next until do begin unless END rescue nil else break undef not super class case require yield alias while ensure elsif or include attr_reader attr_writer attr_accessor";var a={cN:"yardoctag",b:"@[A-Za-z]+"};var i={cN:"comment",v:[{b:"#",e:"$",c:[a]},{b:"^\\=begin",e:"^\\=end",c:[a],r:10},{b:"^__END__",e:"\\n$"}]};var c={cN:"subst",b:"#\\{",e:"}",k:g};var d={cN:"string",c:[e.BE,c],v:[{b:/'/,e:/'/},{b:/"/,e:/"/},{b:"%[qw]?\\(",e:"\\)"},{b:"%[qw]?\\[",e:"\\]"},{b:"%[qw]?{",e:"}"},{b:"%[qw]?<",e:">",r:10},{b:"%[qw]?/",e:"/",r:10},{b:"%[qw]?%",e:"%",r:10},{b:"%[qw]?-",e:"-",r:10},{b:"%[qw]?\\|",e:"\\|",r:10},{b:/\B\?(\\\d{1,3}|\\x[A-Fa-f0-9]{1,2}|\\u[A-Fa-f0-9]{4}|\\?\S)\b/}]};var b={cN:"params",b:"\\(",e:"\\)",k:g};var f=[d,i,{cN:"class",bK:"class module",e:"$|;",i:/=/,c:[e.inherit(e.TM,{b:"[A-Za-z_]\\w*(::\\w+)*(\\?|\\!)?"}),{cN:"inheritance",b:"<\\s*",c:[{cN:"parent",b:"("+e.IR+"::)?"+e.IR}]},i]},{cN:"function",bK:"def",e:" |$|;",r:0,c:[e.inherit(e.TM,{b:h}),b,i]},{cN:"constant",b:"(::)?(\\b[A-Z]\\w*(::)?)+",r:0},{cN:"symbol",b:":",c:[d,{b:h}],r:0},{cN:"symbol",b:e.UIR+"(\\!|\\?)?:",r:0},{cN:"number",b:"(\\b0[0-7_]+)|(\\b0x[0-9a-fA-F_]+)|(\\b[1-9][0-9_]*(\\.[0-9_]+)?)|[0_]\\b",r:0},{cN:"variable",b:"(\\$\\W)|((\\$|\\@\\@?)(\\w+))"},{b:"("+e.RSR+")\\s*",c:[i,{cN:"regexp",c:[e.BE,c],i:/\n/,v:[{b:"/",e:"/[a-z]*"},{b:"%r{",e:"}[a-z]*"},{b:"%r\\(",e:"\\)[a-z]*"},{b:"%r!",e:"![a-z]*"},{b:"%r\\[",e:"\\][a-z]*"}]}],r:0}];c.c=f;b.c=f;return{k:g,c:f}});hljs.registerLanguage("javascript",function(a){return{aliases:["js"],k:{keyword:"in if for while finally var new function do return void else break catch instanceof with throw case default try this switch continue typeof delete let yield const class",literal:"true false null undefined NaN Infinity",built_in:"eval isFinite isNaN parseFloat parseInt decodeURI decodeURIComponent encodeURI encodeURIComponent escape unescape Object Function Boolean Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError Number Math Date String RegExp Array Float32Array Float64Array Int16Array Int32Array Int8Array Uint16Array Uint32Array Uint8Array Uint8ClampedArray ArrayBuffer DataView JSON Intl arguments require"},c:[{cN:"pi",b:/^\s*('|")use strict('|")/,r:10},a.ASM,a.QSM,a.CLCM,a.CBLCLM,a.CNM,{b:"("+a.RSR+"|\\b(case|return|throw)\\b)\\s*",k:"return throw case",c:[a.CLCM,a.CBLCLM,a.REGEXP_MODE,{b:/</,e:/>;/,r:0,sL:"xml"}],r:0},{cN:"function",bK:"function",e:/\{/,c:[a.inherit(a.TM,{b:/[A-Za-z$_][0-9A-Za-z$_]*/}),{cN:"params",b:/\(/,e:/\)/,c:[a.CLCM,a.CBLCLM],i:/["'\(]/}],i:/\[|%/},{b:/\$[(.]/},{b:"\\."+a.IR,r:0}]}});hljs.registerLanguage("xml",function(a){var c="[A-Za-z0-9\\._:-]+";var d={b:/<\?(php)?(?!\w)/,e:/\?>/,sL:"php",subLanguageMode:"continuous"};var b={eW:true,i:/</,r:0,c:[d,{cN:"attribute",b:c,r:0},{b:"=",r:0,c:[{cN:"value",v:[{b:/"/,e:/"/},{b:/'/,e:/'/},{b:/[^\s\/>]+/}]}]}]};return{aliases:["html"],cI:true,c:[{cN:"doctype",b:"<!DOCTYPE",e:">",r:10,c:[{b:"\\[",e:"\\]"}]},{cN:"comment",b:"<!--",e:"-->",r:10},{cN:"cdata",b:"<\\!\\[CDATA\\[",e:"\\]\\]>",r:10},{cN:"tag",b:"<style(?=\\s|>|$)",e:">",k:{title:"style"},c:[b],starts:{e:"</style>",rE:true,sL:"css"}},{cN:"tag",b:"<script(?=\\s|>|$)",e:">",k:{title:"script"},c:[b],starts:{e:"<\/script>",rE:true,sL:"javascript"}},{b:"<%",e:"%>",sL:"vbscript"},d,{cN:"pi",b:/<\?\w+/,e:/\?>/,r:10},{cN:"tag",b:"</?",e:"/?>",c:[{cN:"title",b:"[^ /><]+",r:0},b]}]}});hljs.registerLanguage("markdown",function(a){return{c:[{cN:"header",v:[{b:"^#{1,6}",e:"$"},{b:"^.+?\\n[=-]{2,}$"}]},{b:"<",e:">",sL:"xml",r:0},{cN:"bullet",b:"^([*+-]|(\\d+\\.))\\s+"},{cN:"strong",b:"[*_]{2}.+?[*_]{2}"},{cN:"emphasis",v:[{b:"\\*.+?\\*"},{b:"_.+?_",r:0}]},{cN:"blockquote",b:"^>\\s+",e:"$"},{cN:"code",v:[{b:"`.+?`"},{b:"^( {4}|\t)",e:"$",r:0}]},{cN:"horizontal_rule",b:"^[-\\*]{3,}",e:"$"},{b:"\\[.+?\\][\\(\\[].+?[\\)\\]]",rB:true,c:[{cN:"link_label",b:"\\[",e:"\\]",eB:true,rE:true,r:0},{cN:"link_url",b:"\\]\\(",e:"\\)",eB:true,eE:true},{cN:"link_reference",b:"\\]\\[",e:"\\]",eB:true,eE:true,}],r:10},{b:"^\\[.+\\]:",e:"$",rB:true,c:[{cN:"link_reference",b:"\\[",e:"\\]",eB:true,eE:true},{cN:"link_url",b:"\\s",e:"$"}]}]}});hljs.registerLanguage("css",function(a){var b="[a-zA-Z-][a-zA-Z0-9_-]*";var c={cN:"function",b:b+"\\(",e:"\\)",c:["self",a.NM,a.ASM,a.QSM]};return{cI:true,i:"[=/|']",c:[a.CBLCLM,{cN:"id",b:"\\#[A-Za-z0-9_-]+"},{cN:"class",b:"\\.[A-Za-z0-9_-]+",r:0},{cN:"attr_selector",b:"\\[",e:"\\]",i:"$"},{cN:"pseudo",b:":(:)?[a-zA-Z0-9\\_\\-\\+\\(\\)\\\"\\']+"},{cN:"at_rule",b:"@(font-face|page)",l:"[a-z-]+",k:"font-face page"},{cN:"at_rule",b:"@",e:"[{;]",c:[{cN:"keyword",b:/\S+/},{b:/\s/,eW:true,eE:true,r:0,c:[c,a.ASM,a.QSM,a.NM]}]},{cN:"tag",b:b,r:0},{cN:"rules",b:"{",e:"}",i:"[^\\s]",r:0,c:[a.CBLCLM,{cN:"rule",b:"[^\\s]",rB:true,e:";",eW:true,c:[{cN:"attribute",b:"[A-Z\\_\\.\\-]+",e:":",eE:true,i:"[^\\s]",starts:{cN:"value",eW:true,eE:true,c:[c,a.NM,a.QSM,a.ASM,a.CBLCLM,{cN:"hexcolor",b:"#[0-9A-Fa-f]+"},{cN:"important",b:"!important"}]}}]}]}]}});hljs.registerLanguage("http",function(a){return{i:"\\S",c:[{cN:"status",b:"^HTTP/[0-9\\.]+",e:"$",c:[{cN:"number",b:"\\b\\d{3}\\b"}]},{cN:"request",b:"^[A-Z]+ (.*?) HTTP/[0-9\\.]+$",rB:true,e:"$",c:[{cN:"string",b:" ",e:" ",eB:true,eE:true}]},{cN:"attribute",b:"^\\w",e:": ",eE:true,i:"\\n|\\s|=",starts:{cN:"string",e:"$"}},{b:"\\n\\n",starts:{sL:"",eW:true}}]}});hljs.registerLanguage("php",function(b){var e={cN:"variable",b:"\\$+[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*"};var a={cN:"preprocessor",b:/<\?(php)?|\?>/};var c={cN:"string",c:[b.BE,a],v:[{b:'b"',e:'"'},{b:"b'",e:"'"},b.inherit(b.ASM,{i:null}),b.inherit(b.QSM,{i:null})]};var d={v:[b.BNM,b.CNM]};return{cI:true,k:"and include_once list abstract global private echo interface as static endswitch array null if endwhile or const for endforeach self var while isset public protected exit foreach throw elseif include __FILE__ empty require_once do xor return parent clone use __CLASS__ __LINE__ else break print eval new catch __METHOD__ case exception default die require __FUNCTION__ enddeclare final try switch continue endfor endif declare unset true false trait goto instanceof insteadof __DIR__ __NAMESPACE__ yield finally",c:[b.CLCM,b.HCM,{cN:"comment",b:"/\\*",e:"\\*/",c:[{cN:"phpdoc",b:"\\s@[A-Za-z]+"},a]},{cN:"comment",b:"__halt_compiler.+?;",eW:true,k:"__halt_compiler",l:b.UIR},{cN:"string",b:"<<<['\"]?\\w+['\"]?$",e:"^\\w+;",c:[b.BE]},a,e,{cN:"function",bK:"function",e:/[;{]/,i:"\\$|\\[|%",c:[b.UTM,{cN:"params",b:"\\(",e:"\\)",c:["self",e,b.CBLCLM,c,d]}]},{cN:"class",bK:"class interface",e:"{",i:/[:\(\$"]/,c:[{bK:"extends implements",r:10},b.UTM]},{bK:"namespace",e:";",i:/[\.']/,c:[b.UTM]},{bK:"use",e:";",c:[b.UTM]},{b:"=>"},c,d]}});hljs.registerLanguage("python",function(a){var f={cN:"prompt",b:/^(>>>|\.\.\.) /};var b={cN:"string",c:[a.BE],v:[{b:/(u|b)?r?'''/,e:/'''/,c:[f],r:10},{b:/(u|b)?r?"""/,e:/"""/,c:[f],r:10},{b:/(u|r|ur)'/,e:/'/,r:10},{b:/(u|r|ur)"/,e:/"/,r:10},{b:/(b|br)'/,e:/'/,},{b:/(b|br)"/,e:/"/,},a.ASM,a.QSM]};var d={cN:"number",r:0,v:[{b:a.BNR+"[lLjJ]?"},{b:"\\b(0o[0-7]+)[lLjJ]?"},{b:a.CNR+"[lLjJ]?"}]};var e={cN:"params",b:/\(/,e:/\)/,c:["self",f,d,b]};var c={e:/:/,i:/[${=;\n]/,c:[a.UTM,e]};return{k:{keyword:"and elif is global as in if from raise for except finally print import pass return exec else break not with class assert yield try while continue del or def lambda nonlocal|10 None True False",built_in:"Ellipsis NotImplemented"},i:/(<\/|->|\?)/,c:[f,d,b,a.HCM,a.inherit(c,{cN:"function",bK:"def",r:10}),a.inherit(c,{cN:"class",bK:"class"}),{cN:"decorator",b:/@/,e:/$/},{b:/\b(print|exec)\(/}]}});hljs.registerLanguage("sql",function(a){return{cI:true,i:/[<>]/,c:[{cN:"operator",b:"\\b(begin|end|start|commit|rollback|savepoint|lock|alter|create|drop|rename|call|delete|do|handler|insert|load|replace|select|truncate|update|set|show|pragma|grant|merge)\\b(?!:)",e:";",eW:true,k:{keyword:"all partial global month current_timestamp using go revoke smallint indicator end-exec disconnect zone with character assertion to add current_user usage input local alter match collate real then rollback get read timestamp session_user not integer bit unique day minute desc insert execute like ilike|2 level decimal drop continue isolation found where constraints domain right national some module transaction relative second connect escape close system_user for deferred section cast current sqlstate allocate intersect deallocate numeric public preserve full goto initially asc no key output collation group by union session both last language constraint column of space foreign deferrable prior connection unknown action commit view or first into float year primary cascaded except restrict set references names table outer open select size are rows from prepare distinct leading create only next inner authorization schema corresponding option declare precision immediate else timezone_minute external varying translation true case exception join hour default double scroll value cursor descriptor values dec fetch procedure delete and false int is describe char as at in varchar null trailing any absolute current_time end grant privileges when cross check write current_date pad begin temporary exec time update catalog user sql date on identity timezone_hour natural whenever interval work order cascade diagnostics nchar having left call do handler load replace truncate start lock show pragma exists number trigger if before after each row merge matched database",aggregate:"count sum min max avg"},c:[{cN:"string",b:"'",e:"'",c:[a.BE,{b:"''"}]},{cN:"string",b:'"',e:'"',c:[a.BE,{b:'""'}]},{cN:"string",b:"`",e:"`",c:[a.BE]},a.CNM]},a.CBLCLM,{cN:"comment",b:"--",e:"$"}]}});hljs.registerLanguage("coffeescript",function(c){var b={keyword:"in if for while finally new do return else break catch instanceof throw try this switch continue typeof delete debugger super then unless until loop of by when and or is isnt not",literal:"true false null undefined yes no on off",reserved:"case default function var void with const let enum export import native __hasProp __extends __slice __bind __indexOf",built_in:"npm require console print module exports global window document"};var a="[A-Za-z$_][0-9A-Za-z$_]*";var f=c.inherit(c.TM,{b:a});var e={cN:"subst",b:/#\{/,e:/}/,k:b};var d=[c.BNM,c.inherit(c.CNM,{starts:{e:"(\\s*/)?",r:0}}),{cN:"string",v:[{b:/'''/,e:/'''/,c:[c.BE]},{b:/'/,e:/'/,c:[c.BE]},{b:/"""/,e:/"""/,c:[c.BE,e]},{b:/"/,e:/"/,c:[c.BE,e]}]},{cN:"regexp",v:[{b:"///",e:"///",c:[e,c.HCM]},{b:"//[gim]*",r:0},{b:"/\\S(\\\\.|[^\\n])*?/[gim]*(?=\\s|\\W|$)"}]},{cN:"property",b:"@"+a},{b:"`",e:"`",eB:true,eE:true,sL:"javascript"}];e.c=d;return{k:b,c:d.concat([{cN:"comment",b:"###",e:"###"},c.HCM,{cN:"function",b:"("+a+"\\s*=\\s*)?(\\(.*\\))?\\s*\\B[-=]>",e:"[-=]>",rB:true,c:[f,{cN:"params",b:"\\(",rB:true,c:[{b:/\(/,e:/\)/,k:b,c:["self"].concat(d)}]}]},{cN:"class",bK:"class",e:"$",i:/[:="\[\]]/,c:[{bK:"extends",eW:true,i:/[:="\[\]]/,c:[f]},f]},{cN:"attribute",b:a+":",e:":",rB:true,eE:true,r:0}])}});hljs.registerLanguage("nginx",function(c){var b={cN:"variable",v:[{b:/\$\d+/},{b:/\$\{/,e:/}/},{b:"[\\$\\@]"+c.UIR}]};var a={eW:true,l:"[a-z/_]+",k:{built_in:"on off yes no true false none blocked debug info notice warn error crit select break last permanent redirect kqueue rtsig epoll poll /dev/poll"},r:0,i:"=>",c:[c.HCM,{cN:"string",c:[c.BE,b],v:[{b:/"/,e:/"/},{b:/'/,e:/'/}]},{cN:"url",b:"([a-z]+):/",e:"\\s",eW:true,eE:true},{cN:"regexp",c:[c.BE,b],v:[{b:"\\s\\^",e:"\\s|{|;",rE:true},{b:"~\\*?\\s+",e:"\\s|{|;",rE:true},{b:"\\*(\\.[a-z\\-]+)+"},{b:"([a-z\\-]+\\.)+\\*"}]},{cN:"number",b:"\\b\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}(:\\d{1,5})?\\b"},{cN:"number",b:"\\b\\d+[kKmMgGdshdwy]*\\b",r:0},b]};return{c:[c.HCM,{b:c.UIR+"\\s",e:";|{",rB:true,c:[c.inherit(c.UTM,{starts:a})],r:0}],i:"[^\\s\\}]"}});hljs.registerLanguage("json",function(a){var e={literal:"true false null"};var d=[a.QSM,a.CNM];var c={cN:"value",e:",",eW:true,eE:true,c:d,k:e};var b={b:"{",e:"}",c:[{cN:"attribute",b:'\\s*"',e:'"\\s*:\\s*',eB:true,eE:true,c:[a.BE],i:"\\n",starts:c}],i:"\\S"};var f={b:"\\[",e:"\\]",c:[a.inherit(c,{cN:null})],i:"\\S"};d.splice(d.length,0,b,f);return{c:d,k:e,i:"\\S"}});hljs.registerLanguage("cpp",function(a){var b={keyword:"false int float while private char catch export virtual operator sizeof dynamic_cast|10 typedef const_cast|10 const struct for static_cast|10 union namespace unsigned long throw volatile static protected bool template mutable if public friend do return goto auto void enum else break new extern using true class asm case typeid short reinterpret_cast|10 default double register explicit signed typename try this switch continue wchar_t inline delete alignof char16_t char32_t constexpr decltype noexcept nullptr static_assert thread_local restrict _Bool complex _Complex _Imaginary",built_in:"std string cin cout cerr clog stringstream istringstream ostringstream auto_ptr deque list queue stack vector map set bitset multiset multimap unordered_set unordered_map unordered_multiset unordered_multimap array shared_ptr abort abs acos asin atan2 atan calloc ceil cosh cos exit exp fabs floor fmod fprintf fputs free frexp fscanf isalnum isalpha iscntrl isdigit isgraph islower isprint ispunct isspace isupper isxdigit tolower toupper labs ldexp log10 log malloc memchr memcmp memcpy memset modf pow printf putchar puts scanf sinh sin snprintf sprintf sqrt sscanf strcat strchr strcmp strcpy strcspn strlen strncat strncmp strncpy strpbrk strrchr strspn strstr tanh tan vfprintf vprintf vsprintf"};return{aliases:["c"],k:b,i:"</",c:[a.CLCM,a.CBLCLM,a.QSM,{cN:"string",b:"'\\\\?.",e:"'",i:"."},{cN:"number",b:"\\b(\\d+(\\.\\d*)?|\\.\\d+)(u|U|l|L|ul|UL|f|F)"},a.CNM,{cN:"preprocessor",b:"#",e:"$",c:[{b:"include\\s*<",e:">",i:"\\n"},a.CLCM]},{cN:"stl_container",b:"\\b(deque|list|queue|stack|vector|map|set|bitset|multiset|multimap|unordered_map|unordered_set|unordered_multiset|unordered_multimap|array)\\s*<",e:">",k:b,r:10,c:["self"]}]}});

// /*
// Syntax highlighting with language autodetection.
// http://highlightjs.org/
// */

// var hljs = new function() {

//   /* Utility functions */

//   function escape(value) {
//     return value.replace(/&/gm, '&amp;').replace(/</gm, '&lt;').replace(/>/gm, '&gt;');
//   }

//   function tag(node) {
//     return node.nodeName.toLowerCase();
//   }

//   function testRe(re, lexeme) {
//     var match = re && re.exec(lexeme);
//     return match && match.index == 0;
//   }

//   function blockText(block) {
//     return Array.prototype.map.call(block.childNodes, function(node) {
//       if (node.nodeType == 3) {
//         return options.useBR ? node.nodeValue.replace(/\n/g, '') : node.nodeValue;
//       }
//       if (tag(node) == 'br') {
//         return '\n';
//       }
//       return blockText(node);
//     }).join('');
//   }

//   function blockLanguage(block) {
//     var classes = (block.className + ' ' + (block.parentNode ? block.parentNode.className : '')).split(/\s+/);
//     classes = classes.map(function(c) {return c.replace(/^lang(uage)?-/, '');});
//     return classes.filter(function(c) {return getLanguage(c) || c == 'no-highlight';})[0];
//   }

//   function inherit(parent, obj) {
//     var result = {};
//     for (var key in parent)
//       result[key] = parent[key];
//     if (obj)
//       for (var key in obj)
//         result[key] = obj[key];
//     return result;
//   };

//   /* Stream merging */

//   function nodeStream(node) {
//     var result = [];
//     (function _nodeStream(node, offset) {
//       for (var child = node.firstChild; child; child = child.nextSibling) {
//         if (child.nodeType == 3)
//           offset += child.nodeValue.length;
//         else if (tag(child) == 'br')
//           offset += 1;
//         else if (child.nodeType == 1) {
//           result.push({
//             event: 'start',
//             offset: offset,
//             node: child
//           });
//           offset = _nodeStream(child, offset);
//           result.push({
//             event: 'stop',
//             offset: offset,
//             node: child
//           });
//         }
//       }
//       return offset;
//     })(node, 0);
//     return result;
//   }

//   function mergeStreams(original, highlighted, value) {
//     var processed = 0;
//     var result = '';
//     var nodeStack = [];

//     function selectStream() {
//       if (!original.length || !highlighted.length) {
//         return original.length ? original : highlighted;
//       }
//       if (original[0].offset != highlighted[0].offset) {
//         return (original[0].offset < highlighted[0].offset) ? original : highlighted;
//       }

//       /*
//       To avoid starting the stream just before it should stop the order is
//       ensured that original always starts first and closes last:

//       if (event1 == 'start' && event2 == 'start')
//         return original;
//       if (event1 == 'start' && event2 == 'stop')
//         return highlighted;
//       if (event1 == 'stop' && event2 == 'start')
//         return original;
//       if (event1 == 'stop' && event2 == 'stop')
//         return highlighted;

//       ... which is collapsed to:
//       */
//       return highlighted[0].event == 'start' ? original : highlighted;
//     }

//     function open(node) {
//       function attr_str(a) {return ' ' + a.nodeName + '="' + escape(a.value) + '"';}
//       result += '<' + tag(node) + Array.prototype.map.call(node.attributes, attr_str).join('') + '>';
//     }

//     function close(node) {
//       result += '</' + tag(node) + '>';
//     }

//     function render(event) {
//       (event.event == 'start' ? open : close)(event.node);
//     }

//     while (original.length || highlighted.length) {
//       var stream = selectStream();
//       result += escape(value.substr(processed, stream[0].offset - processed));
//       processed = stream[0].offset;
//       if (stream == original) {
//         /*
//         On any opening or closing tag of the original markup we first close
//         the entire highlighted node stack, then render the original tag along
//         with all the following original tags at the same offset and then
//         reopen all the tags on the highlighted stack.
//         */
//         nodeStack.reverse().forEach(close);
//         do {
//           render(stream.splice(0, 1)[0]);
//           stream = selectStream();
//         } while (stream == original && stream.length && stream[0].offset == processed);
//         nodeStack.reverse().forEach(open);
//       } else {
//         if (stream[0].event == 'start') {
//           nodeStack.push(stream[0].node);
//         } else {
//           nodeStack.pop();
//         }
//         render(stream.splice(0, 1)[0]);
//       }
//     }
//     return result + escape(value.substr(processed));
//   }

//   /* Initialization */

//   function compileLanguage(language) {

//     function reStr(re) {
//         return (re && re.source) || re;
//     }

//     function langRe(value, global) {
//       return RegExp(
//         reStr(value),
//         'm' + (language.case_insensitive ? 'i' : '') + (global ? 'g' : '')
//       );
//     }

//     function compileMode(mode, parent) {
//       if (mode.compiled)
//         return;
//       mode.compiled = true;

//       mode.keywords = mode.keywords || mode.beginKeywords;
//       if (mode.keywords) {
//         var compiled_keywords = {};

//         function flatten(className, str) {
//           if (language.case_insensitive) {
//             str = str.toLowerCase();
//           }
//           str.split(' ').forEach(function(kw) {
//             var pair = kw.split('|');
//             compiled_keywords[pair[0]] = [className, pair[1] ? Number(pair[1]) : 1];
//           });
//         }

//         if (typeof mode.keywords == 'string') { // string
//           flatten('keyword', mode.keywords);
//         } else {
//           Object.keys(mode.keywords).forEach(function (className) {
//             flatten(className, mode.keywords[className]);
//           });
//         }
//         mode.keywords = compiled_keywords;
//       }
//       mode.lexemesRe = langRe(mode.lexemes || /\b[A-Za-z0-9_]+\b/, true);

//       if (parent) {
//         if (mode.beginKeywords) {
//           mode.begin = '\\b(' + mode.beginKeywords.split(' ').join('|') + ')\\b';
//         }
//         if (!mode.begin)
//           mode.begin = /\B|\b/;
//         mode.beginRe = langRe(mode.begin);
//         if (!mode.end && !mode.endsWithParent)
//           mode.end = /\B|\b/;
//         if (mode.end)
//           mode.endRe = langRe(mode.end);
//         mode.terminator_end = reStr(mode.end) || '';
//         if (mode.endsWithParent && parent.terminator_end)
//           mode.terminator_end += (mode.end ? '|' : '') + parent.terminator_end;
//       }
//       if (mode.illegal)
//         mode.illegalRe = langRe(mode.illegal);
//       if (mode.relevance === undefined)
//         mode.relevance = 1;
//       if (!mode.contains) {
//         mode.contains = [];
//       }
//       var expanded_contains = [];
//       mode.contains.forEach(function(c) {
//         if (c.variants) {
//           c.variants.forEach(function(v) {expanded_contains.push(inherit(c, v));});
//         } else {
//           expanded_contains.push(c == 'self' ? mode : c);
//         }
//       });
//       mode.contains = expanded_contains;
//       mode.contains.forEach(function(c) {compileMode(c, mode);});

//       if (mode.starts) {
//         compileMode(mode.starts, parent);
//       }

//       var terminators =
//         mode.contains.map(function(c) {
//           return c.beginKeywords ? '\\.?(' + c.begin + ')\\.?' : c.begin;
//         })
//         .concat([mode.terminator_end, mode.illegal])
//         .map(reStr)
//         .filter(Boolean);
//       mode.terminators = terminators.length ? langRe(terminators.join('|'), true) : {exec: function(s) {return null;}};

//       mode.continuation = {};
//     }

//     compileMode(language);
//   }

//   /*
//   Core highlighting function. Accepts a language name, or an alias, and a
//   string with the code to highlight. Returns an object with the following
//   properties:

//   - relevance (int)
//   - value (an HTML string with highlighting markup)

//   */
//   function highlight(name, value, ignore_illegals, continuation) {

//     function subMode(lexeme, mode) {
//       for (var i = 0; i < mode.contains.length; i++) {
//         if (testRe(mode.contains[i].beginRe, lexeme)) {
//           return mode.contains[i];
//         }
//       }
//     }

//     function endOfMode(mode, lexeme) {
//       if (testRe(mode.endRe, lexeme)) {
//         return mode;
//       }
//       if (mode.endsWithParent) {
//         return endOfMode(mode.parent, lexeme);
//       }
//     }

//     function isIllegal(lexeme, mode) {
//       return !ignore_illegals && testRe(mode.illegalRe, lexeme);
//     }

//     function keywordMatch(mode, match) {
//       var match_str = language.case_insensitive ? match[0].toLowerCase() : match[0];
//       return mode.keywords.hasOwnProperty(match_str) && mode.keywords[match_str];
//     }

//     function buildSpan(classname, insideSpan, leaveOpen, noPrefix) {
//       var classPrefix = noPrefix ? '' : options.classPrefix,
//           openSpan    = '<span class="' + classPrefix,
//           closeSpan   = leaveOpen ? '' : '</span>';

//       openSpan += classname + '">';

//       return openSpan + insideSpan + closeSpan;
//     }

//     function processKeywords() {
//       if (!top.keywords)
//         return escape(mode_buffer);
//       var result = '';
//       var last_index = 0;
//       top.lexemesRe.lastIndex = 0;
//       var match = top.lexemesRe.exec(mode_buffer);
//       while (match) {
//         result += escape(mode_buffer.substr(last_index, match.index - last_index));
//         var keyword_match = keywordMatch(top, match);
//         if (keyword_match) {
//           relevance += keyword_match[1];
//           result += buildSpan(keyword_match[0], escape(match[0]));
//         } else {
//           result += escape(match[0]);
//         }
//         last_index = top.lexemesRe.lastIndex;
//         match = top.lexemesRe.exec(mode_buffer);
//       }
//       return result + escape(mode_buffer.substr(last_index));
//     }

//     function processSubLanguage() {
//       if (top.subLanguage && !languages[top.subLanguage]) {
//         return escape(mode_buffer);
//       }
//       var result = top.subLanguage ? highlight(top.subLanguage, mode_buffer, true, top.continuation.top) : highlightAuto(mode_buffer);
//       // Counting embedded language score towards the host language may be disabled
//       // with zeroing the containing mode relevance. Usecase in point is Markdown that
//       // allows XML everywhere and makes every XML snippet to have a much larger Markdown
//       // score.
//       if (top.relevance > 0) {
//         relevance += result.relevance;
//       }
//       if (top.subLanguageMode == 'continuous') {
//         top.continuation.top = result.top;
//       }
//       return buildSpan(result.language, result.value, false, true);
//     }

//     function processBuffer() {
//       return top.subLanguage !== undefined ? processSubLanguage() : processKeywords();
//     }

//     function startNewMode(mode, lexeme) {
//       var markup = mode.className? buildSpan(mode.className, '', true): '';
//       if (mode.returnBegin) {
//         result += markup;
//         mode_buffer = '';
//       } else if (mode.excludeBegin) {
//         result += escape(lexeme) + markup;
//         mode_buffer = '';
//       } else {
//         result += markup;
//         mode_buffer = lexeme;
//       }
//       top = Object.create(mode, {parent: {value: top}});
//     }

//     function processLexeme(buffer, lexeme) {

//       mode_buffer += buffer;
//       if (lexeme === undefined) {
//         result += processBuffer();
//         return 0;
//       }

//       var new_mode = subMode(lexeme, top);
//       if (new_mode) {
//         result += processBuffer();
//         startNewMode(new_mode, lexeme);
//         return new_mode.returnBegin ? 0 : lexeme.length;
//       }

//       var end_mode = endOfMode(top, lexeme);
//       if (end_mode) {
//         var origin = top;
//         if (!(origin.returnEnd || origin.excludeEnd)) {
//           mode_buffer += lexeme;
//         }
//         result += processBuffer();
//         do {
//           if (top.className) {
//             result += '</span>';
//           }
//           relevance += top.relevance;
//           top = top.parent;
//         } while (top != end_mode.parent);
//         if (origin.excludeEnd) {
//           result += escape(lexeme);
//         }
//         mode_buffer = '';
//         if (end_mode.starts) {
//           startNewMode(end_mode.starts, '');
//         }
//         return origin.returnEnd ? 0 : lexeme.length;
//       }

//       if (isIllegal(lexeme, top))
//         throw new Error('Illegal lexeme "' + lexeme + '" for mode "' + (top.className || '<unnamed>') + '"');

//       /*
//       Parser should not reach this point as all types of lexemes should be caught
//       earlier, but if it does due to some bug make sure it advances at least one
//       character forward to prevent infinite looping.
//       */
//       mode_buffer += lexeme;
//       return lexeme.length || 1;
//     }

//     var language = getLanguage(name);
//     if (!language) {
//       throw new Error('Unknown language: "' + name + '"');
//     }

//     compileLanguage(language);
//     var top = continuation || language;
//     var result = '';
//     for(var current = top; current != language; current = current.parent) {
//       if (current.className) {
//         result += buildSpan(current.className, result, true);
//       }
//     }
//     var mode_buffer = '';
//     var relevance = 0;
//     try {
//       var match, count, index = 0;
//       while (true) {
//         top.terminators.lastIndex = index;
//         match = top.terminators.exec(value);
//         if (!match)
//           break;
//         count = processLexeme(value.substr(index, match.index - index), match[0]);
//         index = match.index + count;
//       }
//       processLexeme(value.substr(index));
//       for(var current = top; current.parent; current = current.parent) { // close dangling modes
//         if (current.className) {
//           result += '</span>';
//         }
//       };
//       return {
//         relevance: relevance,
//         value: result,
//         language: name,
//         top: top
//       };
//     } catch (e) {
//       if (e.message.indexOf('Illegal') != -1) {
//         return {
//           relevance: 0,
//           value: escape(value)
//         };
//       } else {
//         throw e;
//       }
//     }
//   }

//   /*
//   Highlighting with language detection. Accepts a string with the code to
//   highlight. Returns an object with the following properties:

//   - language (detected language)
//   - relevance (int)
//   - value (an HTML string with highlighting markup)
//   - second_best (object with the same structure for second-best heuristically
//     detected language, may be absent)

//   */
//   function highlightAuto(text, languageSubset) {
//     languageSubset = languageSubset || options.languages || Object.keys(languages);
//     var result = {
//       relevance: 0,
//       value: escape(text)
//     };
//     var second_best = result;
//     languageSubset.forEach(function(name) {
//       if (!getLanguage(name)) {
//         return;
//       }
//       var current = highlight(name, text, false);
//       current.language = name;
//       if (current.relevance > second_best.relevance) {
//         second_best = current;
//       }
//       if (current.relevance > result.relevance) {
//         second_best = result;
//         result = current;
//       }
//     });
//     if (second_best.language) {
//       result.second_best = second_best;
//     }
//     return result;
//   }

//   /*
//   Post-processing of the highlighted markup:

//   - replace TABs with something more useful
//   - replace real line-breaks with '<br>' for non-pre containers

//   */
//   function fixMarkup(value) {
//     if (options.tabReplace) {
//       value = value.replace(/^((<[^>]+>|\t)+)/gm, function(match, p1, offset, s) {
//         return p1.replace(/\t/g, options.tabReplace);
//       });
//     }
//     if (options.useBR) {
//       value = value.replace(/\n/g, '<br>');
//     }
//     return value;
//   }

//   /*
//   Applies highlighting to a DOM node containing code. Accepts a DOM node and
//   two optional parameters for fixMarkup.
//   */
//   function highlightBlock(block) {
//     var text = blockText(block);
//     var language = blockLanguage(block);
//     if (language == 'no-highlight')
//         return;
//     var result = language ? highlight(language, text, true) : highlightAuto(text);
//     var original = nodeStream(block);
//     if (original.length) {
//       var pre = document.createElementNS('http://www.w3.org/1999/xhtml', 'pre');
//       pre.innerHTML = result.value;
//       result.value = mergeStreams(original, nodeStream(pre), text);
//     }
//     result.value = fixMarkup(result.value);

//     block.innerHTML = result.value;
//     block.className += ' hljs ' + (!language && result.language || '');
//     block.result = {
//       language: result.language,
//       re: result.relevance
//     };
//     if (result.second_best) {
//       block.second_best = {
//         language: result.second_best.language,
//         re: result.second_best.relevance
//       };
//     }
//   }

//   var options = {
//     classPrefix: 'hljs-',
//     tabReplace: null,
//     useBR: false,
//     languages: undefined
//   };

//   /*
//   Updates highlight.js global options with values passed in the form of an object
//   */
//   function configure(user_options) {
//     options = inherit(options, user_options);
//   }

//   /*
//   Applies highlighting to all <pre><code>..</code></pre> blocks on a page.
//   */
//   function initHighlighting() {
//     if (initHighlighting.called)
//       return;
//     initHighlighting.called = true;

//     var blocks = document.querySelectorAll('pre code');
//     // var blocks = document.querySelectorAll('pre');
//     Array.prototype.forEach.call(blocks, highlightBlock);
//   }

//   /*
//   Attaches highlighting to the page load event.
//   */
//   function initHighlightingOnLoad() {
//     addEventListener('DOMContentLoaded', initHighlighting, false);
//     addEventListener('load', initHighlighting, false);
//   }

//   var languages = {};
//   var aliases = {};

//   function registerLanguage(name, language) {
//     var lang = languages[name] = language(this);
//     if (lang.aliases) {
//       lang.aliases.forEach(function(alias) {aliases[alias] = name;});
//     }
//   }

//   function listLanguages() {
//     return Object.keys(languages);
//   }

//   function getLanguage(name) {
//     return languages[name] || languages[aliases[name]];
//   }

//   /* Interface definition */

//   this.highlight = highlight;
//   this.highlightAuto = highlightAuto;
//   this.fixMarkup = fixMarkup;
//   this.highlightBlock = highlightBlock;
//   this.configure = configure;
//   this.initHighlighting = initHighlighting;
//   this.initHighlightingOnLoad = initHighlightingOnLoad;
//   this.registerLanguage = registerLanguage;
//   this.listLanguages = listLanguages;
//   this.getLanguage = getLanguage;
//   this.inherit = inherit;

//   // Common regexps
//   this.IDENT_RE = '[a-zA-Z][a-zA-Z0-9_]*';
//   this.UNDERSCORE_IDENT_RE = '[a-zA-Z_][a-zA-Z0-9_]*';
//   this.NUMBER_RE = '\\b\\d+(\\.\\d+)?';
//   this.C_NUMBER_RE = '(\\b0[xX][a-fA-F0-9]+|(\\b\\d+(\\.\\d*)?|\\.\\d+)([eE][-+]?\\d+)?)'; // 0x..., 0..., decimal, float
//   this.BINARY_NUMBER_RE = '\\b(0b[01]+)'; // 0b...
//   this.RE_STARTERS_RE = '!|!=|!==|%|%=|&|&&|&=|\\*|\\*=|\\+|\\+=|,|-|-=|/=|/|:|;|<<|<<=|<=|<|===|==|=|>>>=|>>=|>=|>>>|>>|>|\\?|\\[|\\{|\\(|\\^|\\^=|\\||\\|=|\\|\\||~';

//   // Common modes
//   this.BACKSLASH_ESCAPE = {
//     begin: '\\\\[\\s\\S]', relevance: 0
//   };
//   this.APOS_STRING_MODE = {
//     className: 'string',
//     begin: '\'', end: '\'',
//     illegal: '\\n',
//     contains: [this.BACKSLASH_ESCAPE]
//   };
//   this.QUOTE_STRING_MODE = {
//     className: 'string',
//     begin: '"', end: '"',
//     illegal: '\\n',
//     contains: [this.BACKSLASH_ESCAPE]
//   };
//   this.PHRASAL_WORDS_MODE = {
//     begin: /\b(a|an|the|are|I|I'm|isn't|don't|doesn't|won't|but|just|should|pretty|simply|enough|gonna|going|wtf|so|such)\b/
//   }
//   this.C_LINE_COMMENT_MODE = {
//     className: 'comment',
//     begin: '//', end: '$',
//     contains: [this.PHRASAL_WORDS_MODE]
//   };
//   this.C_BLOCK_COMMENT_MODE = {
//     className: 'comment',
//     begin: '/\\*', end: '\\*/',
//     contains: [this.PHRASAL_WORDS_MODE]
//   };
//   this.HASH_COMMENT_MODE = {
//     className: 'comment',
//     begin: '#', end: '$',
//     contains: [this.PHRASAL_WORDS_MODE]
//   };
//   this.NUMBER_MODE = {
//     className: 'number',
//     begin: this.NUMBER_RE,
//     relevance: 0
//   };
//   this.C_NUMBER_MODE = {
//     className: 'number',
//     begin: this.C_NUMBER_RE,
//     relevance: 0
//   };
//   this.BINARY_NUMBER_MODE = {
//     className: 'number',
//     begin: this.BINARY_NUMBER_RE,
//     relevance: 0
//   };
//   this.CSS_NUMBER_MODE = {
//     className: 'number',
//     begin: this.NUMBER_RE + '(' +
//       '%|em|ex|ch|rem'  +
//       '|vw|vh|vmin|vmax' +
//       '|cm|mm|in|pt|pc|px' +
//       '|deg|grad|rad|turn' +
//       '|s|ms' +
//       '|Hz|kHz' +
//       '|dpi|dpcm|dppx' +
//       ')?',
//     relevance: 0
//   };
//   this.REGEXP_MODE = {
//     className: 'regexp',
//     begin: /\//, end: /\/[gim]*/,
//     illegal: /\n/,
//     contains: [
//       this.BACKSLASH_ESCAPE,
//       {
//         begin: /\[/, end: /\]/,
//         relevance: 0,
//         contains: [this.BACKSLASH_ESCAPE]
//       }
//     ]
//   };
//   this.TITLE_MODE = {
//     className: 'title',
//     begin: this.IDENT_RE,
//     relevance: 0
//   };
//   this.UNDERSCORE_TITLE_MODE = {
//     className: 'title',
//     begin: this.UNDERSCORE_IDENT_RE,
//     relevance: 0
//   };
// }