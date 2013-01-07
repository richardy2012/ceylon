package ceylon.language;

import com.redhat.ceylon.compiler.java.metadata.Ceylon;
import com.redhat.ceylon.compiler.java.metadata.Method;
import com.redhat.ceylon.compiler.java.metadata.Name;
import com.redhat.ceylon.compiler.java.metadata.TypeInfo;
import com.redhat.ceylon.compiler.java.metadata.TypeParameter;
import com.redhat.ceylon.compiler.java.metadata.TypeParameters;

@Ceylon(major = 3)
@Method
public final class min_ {
    
    private min_() {
    }
    
    @TypeParameters({@TypeParameter(value="Element", 
            satisfies="ceylon.language::Comparable<Element>"),
                     @TypeParameter(value="Absent", 
            satisfies="ceylon.language::Null")})
    @TypeInfo(value="Absent|Element", erased=true)
    public static <Element, Absent> 
    Element min(@Name("values")
    @TypeInfo(value="ceylon.language::Iterable<Element>&ceylon.language::ContainerWithFirstElement<Element,Absent>", erased=true)
    final Iterable<? extends Element> values) {
        Element min = (Element) values.getFirst();
        if (min!=null) {
        	java.lang.Object $tmp;
        	for (Iterator<? extends Element> $val$iter$0 = (Iterator<? extends Element>)values.getRest().getIterator(); 
        			!(($tmp = $val$iter$0.next()) instanceof Finished);) {
        		final Element val = (Element) $tmp;
        		if (((Comparable<? super Element>)val).compare(min).smallerThan()) {
        			min = val;
        		}
        	}
        }
        return min;
    }
}
