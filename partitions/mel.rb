partition "drp" do
  label "dev",  :address => "192.168.22.0/24"
  label "qa",   :address => "192.168.23.0/27"
  label "drp",  :address => "192.168.24.0/24"
  label "prod", :address => "192.168.25.0/24"
  label "www.abc.com", :address => "202.111.222.111"
  label "mail.abc.com", :address => "202.111.222.112"
  label "app1.local",     :address => "192.168.24.10"
  label "mail.local",     :address => "192.168.24.11"

  rewrite "drp web" do
    ports 80
    dnat  "www.abc.com" => "app1.local"
  end
  
  rewrite "drp mail" do
    ports 25 
    dnat  "mail.abc.com" => "mail.local"
  end

  rewrite "ssh in" do
    ports 22
    dnat  "www.abc.com" => "app1.local"
  end

  accept "ssh between dev and qa" do
    protocols "tcp"
    ports     22
    from      "dev"
    to        "qa"
  end

end
