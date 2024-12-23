using PythonCall

const camb = pyimport("camb")

const Pm = let
	params = camb.set_params(H0=70)
	params.set_matter_power(redshifts=0:.1:1.5, kmax=9.5)
	res = camb.get_results(params)
	res.get_matter_power_interpolator(nonlinear=false, k_hunit=false, hubble_units=false, extrap_kmax=1e6)
end

calculate_stuff = (R, z) -> let
	integrand = lθ -> let
		kl = lθ/((1+z) * R)
		pyconvert(Float64, Pm.P(z, kl))
	end
	sum(integrand.(50 .* rand(1000)))
end

zvalues = [0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7]
Rvalues = collect(.1:.2:7.0)
@info @. calculate_stuff(Rvalues, zvalues')
