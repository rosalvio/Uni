package proyecto;

import java.util.Arrays;
import java.util.Random;

import org.opt4j.core.problem.Creator;
import org.opt4j.core.genotype.IntegerGenotype;

public class ProyectoCreator implements Creator<IntegerGenotype>
{
	// Cada generacion 
	public IntegerGenotype create() {
		IntegerGenotype genotipo = new IntegerGenotype(1, DatosVacunas.NUM_VACUNAS);
		genotipo.init(new Random(), DatosVacunas.NUM_GRUPOS);
		return genotipo;
	}
}
