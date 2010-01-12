# adapted from: http://coderack.org/users/sam/entries/21-rackgoogleanalytics

module Rack
  class Layout
    TOP = <<-EOCODE
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta name="description" content="Rubyyot.com is my experiment; part wiki, part blog, part brain dump.  Topics may be scattered according to my interests, ranging from Ruby to teaching my kids to program.">
<meta name="keywords" content="rubyyot, ruby, rails, wiki, rack, thoughts, Jamal Hansen, teaching kids, programming, flannel">
<title>
Rubyyot.com
</title>
<link rel="stylesheet" href="http://rubyyot.com/css/reset.css" type="text/css" media="screen" />
<link rel="stylesheet" href="http://rubyyot.com/css/style.css" type="text/css" media="screen" />
</head>
<body>

<div id="trunk">
EOCODE
 
   BOTTOM = <<-EOCODE
    <script type="text/javascript" src="http://rubyyot.com/javascript/jquery-1.3.2.js"></script> 
    <script type="text/javascript" src="http://rubyyot.com/javascript/jquery.corner.js"></script> 
    <script type="text/javascript"> 
      $("pre").corner("10px");          // curved corners
      $("a[href^=http://]").attr("target", "_blank");       // non wiki links in new tab
    </script> 
  </div>
</body>
</html> 
EOCODE
    
    def initialize(*args)
      @app = args[0]
      @id = args[1]
    end
    
    def call(env)
      status, headers, body = @app.call(env)
      
      body = [TOP, body , BOTTOM].flatten if status == 200
	  
      [status, headers, body]
    end
  
  private
    def tracking_code
      TRACKING_CODE.sub(/\{\{ID\}\}/, @id)
    end
  end
end