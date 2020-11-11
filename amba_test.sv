
module amba_test(Probe_Intf probeIntf, intf dutintf);

	amba_environment dutEnv;

	initial
	begin
		dutEnv = new(dutintf,dutintf_2);
		dutEnv.build();



		repeat(65535)
		begin

			dutEnv.run();
			$display("");
			$display("*******************************************************************************************************");
			$display("");
			#10 ;
		end
	end

endmodule