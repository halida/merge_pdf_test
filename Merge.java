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
        
        for (int i = 0; i < files.length; i++) {
            PdfReader reader = new PdfReader(files[i]);
            copy.addDocument(reader);
            copy.freeReader(reader);
            reader.close();
        }
        document.close();
        copy.close();
    }
}
