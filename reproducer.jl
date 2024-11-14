using PythonCall

const camb = pyimport("camb")

const Pm = let
	params = camb.set_params(H0=70)
	params.set_matter_power(redshifts=0:.1:1.5, kmax=9.5)
	res = camb.get_results(params)
	power = res.get_matter_power_interpolator(nonlinear=false, k_hunit=false, hubble_units=false, extrap_kmax=1e6).P
	(z, k) -> let
		pyval = power(z, k)
		pyconvert(Float64, pyval)
	end
end

calculate_stuff = (R, z) -> let
	θ = R/900.
	integrand = lθ -> let
		kl = lθ/((1+z) * R)
		sqrt(lθ)*cos(lθ)*Pm(z, kl) / (θ*θ)
	end
	sum(integrand.(50 .* rand(1000)))
end

zvalues = [0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7]
Rvalues = collect(.1:.2:7.0)
@info @. calculate_stuff(Rvalues, zvalues')
