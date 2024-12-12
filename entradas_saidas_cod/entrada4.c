leint main() {
	leint a, b;
	b = 60;
	a = 0;
	call_pr(b > a){
		shoots(a < 10)
			a = a+(b/3);
		rebound shoots(a < 20)
			a = a+b/6;
			rebound
				a = a+1;
			shotclock_expired
		shotclock_expired
	}
}
