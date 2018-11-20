package com.nhn.gan.common.utils;

import eu.bitwalker.useragentutils.Browser;
import eu.bitwalker.useragentutils.UserAgent;
import net.sf.jxls.transformer.XLSTransformer;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.Resource;
import org.springframework.web.context.support.ServletContextResource;
import org.springframework.web.servlet.view.AbstractView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;
import java.util.Map;

/**
 * Excel View
 *
 * @author yongseoklee
 * @since 0.0.1
 */
public class ExcelView extends AbstractView {

	Logger logger = LoggerFactory.getLogger(getClass());
    /**
     * Excel contentType
     */
    public static final String CONTENT_TYPE = "application/vnd.ms-excel";

    private String prefix;

    private String downloadFilename;

    private String templateFilename;

    private DefaultFilenameEncoder filenameEncoder = new DefaultFilenameEncoder();

    public ExcelView() {
        setContentType(CONTENT_TYPE);
    }

    @Override
    protected boolean generatesDownloadContent() {
        return true;
    }

    /**
     * 다운로드 헤더 준비
     *
     * @param request
     * @param response
     * @param filename
     * @throws UnsupportedEncodingException
     */
    protected void prepareAttachmentFilename(HttpServletRequest request, HttpServletResponse response, String filename)
            throws UnsupportedEncodingException {
    	logger.info("FILE NAME PATH : {}", filename);
        String encodeFilename = this.filenameEncoder.encode(request, filename);
        logger.info("TEMPLATE PATH : {}", encodeFilename);
        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", encodeFilename));
    }

    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
                                           HttpServletResponse response) throws Exception {
        Resource template = this.getTemplateResource(request);
        String filename = this.getFilename(request);

        prepareAttachmentFilename(request, response, filename);

        XLSTransformer transformer = new XLSTransformer();

        Workbook workbook = transformer.transformXLS(template.getInputStream(), model);

        // Flush byte array to servlet output stream.
        ServletOutputStream out = response.getOutputStream();
        workbook.write(out);
        out.flush();
        out.close();
    }

    public String getDownloadFilename() {
        return downloadFilename;
    }

    public void setDownloadFilename(String downloadFilename) {
        this.downloadFilename = downloadFilename;
    }

    public String getTemplateFilename() {
        return templateFilename;
    }

    public void setTemplateFilename(String templateFilename) {
        this.templateFilename = templateFilename;
    }

    public String getPrefix() {
        return prefix;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    /**
     * 다운로드 파일명 조회
     *
     * @return
     * @throws FileNotFoundException
     */
    public String getFilename(HttpServletRequest request) throws FileNotFoundException {
        String filename = this.getTemplateResource(request).getFilename();

        if (this.getDownloadFilename() != null) {
            filename = this.getDownloadFilename();
        }

        return filename;
    }

    /**
     * 템플릿 조회
     *
     * @return
     * @throws FileNotFoundException
     */
    public Resource getTemplateResource(HttpServletRequest request) throws FileNotFoundException {
        Resource template;

        template = new ServletContextResource(request.getServletContext(), getPrefix() + "/" + getTemplateFilename());
        if (template.exists()) {
            return template;
        }

        throw new FileNotFoundException("Excel templateFilename not found");
    }


    public static class DefaultFilenameEncoder {

        public String encode(HttpServletRequest request, String filename) throws UnsupportedEncodingException {
            String userAgentString = request.getHeader("User-Agent");
            if (userAgentString == null)
                return filename;

            UserAgent userAgent = UserAgent.parseUserAgentString(userAgentString);
            Browser browser = userAgent.getBrowser();
            String encoding = request.getCharacterEncoding();

            if (Browser.IE.equals(browser.getGroup()))
                return java.net.URLEncoder.encode(filename, encoding);
            else
                return new String(filename.getBytes(encoding), "ISO-8859-1");
        }

    }

}