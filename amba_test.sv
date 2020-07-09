
module amba_test(Probe_Intf probeIntf, intf dutintf);

	amba_environment dutEnv;

	initial
	begin
		dutEnv = new(probeIntf,dutintf);
		dutEnv.build();



		repeat(65535)
		begin

			dutEnv.run();
			if(probeIntf.preset)
				dutEnv.dutScb.pcInit();
			$display("");
			$display("*******************************************************************************************************");
			$display("");
			#10 ;
		end
	end

endmodule