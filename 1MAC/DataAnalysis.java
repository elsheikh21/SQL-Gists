import java.util.Arrays;

public class DataAnalysis {
	public double findMean(double[] arr) {
		int sum = 0;
		int size = arr.length;
		for(int i = 0; i < arr.length; i++) 
			sum+= arr[i];
		double avg = sum / size;
		return avg;
	}

	public double findMedian(double[] numArray) {
		double median;
		if (numArray.length % 2 == 0)
		    median = ((double)numArray[numArray.length/2] + (double)numArray[numArray.length/2 - 1])/2;
		else
		    median = (double) numArray[numArray.length/2];
		return median;
	}

	public double findVariance(double[] data) {
		double mean = findMean(data);
		double variance;
		for (int i = 0; i < data.length; i++) 
	    	variance += (data[i] - mean) * (data[i] - mean);

		variance /= data.length;
		return variance;
	}

	public double findStdDeviation(double[] array) {
		double variance = findVariance(array);
		double std = Math.sqrt(variance);
		return std;
	}
}