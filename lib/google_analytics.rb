# adapted from: http://coderack.org/users/sam/entries/21-rackgoogleanalytics

module Rack
  class GoogleAnalytics
    TRACKING_CODE = <<-EOCODE
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("{{ID}}");
pageTracker._trackPageview();
} catch(err) {}</script>
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