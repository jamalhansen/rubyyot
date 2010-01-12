
module Rack
  class Disqus
    TRACKING_CODE = <<-EOCODE
<div id="disqus_thread"></div><script type="text/javascript"
src="http://disqus.com/forums/{{ID}}/embed.js"></script><noscript><a
href="http://disqus.com/forums/{{ID}}/?url=ref">View the discussion
thread.</a></noscript><a href="http://disqus.com" class="dsq-brlink">blog
comments powered by <span class="logo-disqus">Disqus</span></a>
<script type="text/javascript">
//<![CDATA[
(function() {
	var links = document.getElementsByTagName('a');
	var query = '?';
	for(var i = 0; i < links.length; i++) {
	if(links[i].href.indexOf('#disqus_thread') >= 0) {
		query += 'url' + i + '=' + encodeURIComponent(links[i].href) +
'&';
	}
	}
	document.write('<script charset="utf-8" type="text/javascript"
src="http://disqus.com/forums/{{ID}}/get_num_replies.js' + query + '"></' +
'script>');
})();
//]]>
</script>
EOCODE
    
    def initialize(*args)
      @app = args[0]
      @id = args[1]
    end
    
    def call(env)
      status, headers, body = @app.call(env)
      
      body = body.collect do |part|
        if part =~ /<\/body>/
          part.sub(/<\/body>/, "#{tracking_code}</body>")
	else
	  part
        end
      end
      
      [status, headers, body]
    end
  
  private
    def tracking_code
      TRACKING_CODE.sub(/\{\{ID\}\}/, @id)
    end
  end
end