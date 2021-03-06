let
	# A → C ← B
	bn = BayesNet()
	push!(bn, StaticCPD(:a, Categorical([1.0,0.0])))
	push!(bn, StaticCPD(:b, Categorical([0.0,1.0])))
	push!(bn, CategoricalCPD{Bernoulli}(:c, [:a, :b], [2,2], [Bernoulli(0.1), Bernoulli(0.2), Bernoulli(1.0), Bernoulli(0.4)]))

	@test rand(bn) == Dict(:a=>1, :b=>2, :c=>1)

	t1 = rand(bn, 5)
	@test size(t1) == (5,3)
	@test t1[:a] == [1,1,1,1,1]
	@test t1[:b] == [2,2,2,2,2]

	t2 = rand(bn, 5, Assignment(:c=>1))
	@test size(t1) == (5,3)

	t3 = rand(bn, 5, :c=>1, :b=>2)
	@test size(t1) == (5,3)

	t4 = rand_table_weighted(bn; nsamples=5, consistent_with=Assignment(:c=>1))

end
