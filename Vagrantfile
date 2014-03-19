Vagrant.configure("2") do |config|  
	config.vm.box = "mybox"
	config.vm.box_url = "precise32.box"
	config.vm.provider "virtualbox" do |v|
		v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
		v.customize ["modifyvm", :id, "--cpus", "2"]
		v.customize ["modifyvm", :id, "--ioapic", "on"]
		v.memory = 2048
	end
 
	config.vm.define :LB01 do |lb01| 
		lb01.vm.hostname = "LB01"
		lb01.vm.network :private_network, ip: "192.168.10.10"
		lb01.vm.provision "shell", path: "bootstraplb01.sh"
	end

	config.vm.define :TXN01 do |txn01| 
		txn01.vm.hostname = "TXN01"
		txn01.vm.network :private_network, ip: "192.168.10.7"
		txn01.vm.provision "shell", path: "bootstraptxn01.sh"
	end

	config.vm.define :TXF01 do |txf01| 
		txf01.vm.hostname = "TXF01"
		txf01.vm.network :private_network, ip: "192.168.10.6"
		txf01.vm.provision :shell, :path => "bootstraptxf01.sh"
	end

	config.vm.define :TXW01 do |txw01| 
		txw01.vm.hostname = "TXW01"
		txw01.vm.network :private_network, ip: "192.168.10.2"
		txw01.vm.provision "shell", path: "bootstraptxw01.sh"
	end

	config.vm.define :TXW02 do |txw02| 
		txw02.vm.hostname = "TXW02"
		txw02.vm.network :private_network, ip: "192.168.10.3"
		txw02.vm.provision "shell", path: "bootstraptxw02.sh"
	end

end

