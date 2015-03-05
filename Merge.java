import java.util.Arrays;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.PdfCopy;
import com.itextpdf.text.pdf.PdfReader;

public class Merge {

    public static void main(String[] args)
        throws IOException, DocumentException, SQLException {

        String[] files = Arrays.copyOfRange(args, 1, args.length-1);
        String result = args[args.length-1];
        
        Document document = new Document();
        PdfCopy copy = new PdfCopy(document, new FileOutputStream(result));
        document.open();
        PdfReader reader;
        
        int n;
        // loop over the documents you want to merge
        for (int i = 0; i < files.length; i++) {
            reader = new PdfReader(files[i]);
            // loop over the pages in that document
            n = reader.getNumberOfPages();
            for (int page = 0; page < n; ) {
                copy.addPage(copy.getImportedPage(reader, ++page));
            }
            copy.freeReader(reader);
            reader.close();
        }
        // step 5
        document.close();
    }
}
