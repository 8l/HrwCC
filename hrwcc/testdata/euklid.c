

int euklidggt( int var1, int var2 )
{
		int div;
		int mod;


		//Swap both
		//Make that var1>=var2
		if( var1 < var2 )
		{
				div = var1;
				var1 = var2;
				var2 = div;
		}


		while( var2 > 1 )
		{
			div = var1 / var2;
			mod = var1 % var2;

			var1 = var2;
			var2 = mod;
		}

		return var1;
}


int main(int argc, char** argv)
{
		return euklidggt(25,30);
}



