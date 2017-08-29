package org.jrc.springfortune.controller;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.jrc.common.utils.JSONUtil;
import org.jrc.common.utils.Utils;
import org.jrc.springfortune.entity.ExecuteResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.swetake.util.Qrcode;

@Controller
public class QrcodeController extends BaseController
{

	@RequestMapping("qrcode.htm")
	public void test(HttpServletRequest request,HttpServletResponse response) throws IOException
	{
		ExecuteResult result = new ExecuteResult();
		result.setSuccess(true);
		
		String content = getParameter(request, "content");
		
		//这样转换有问题，待处理
		/*int width= Utils.parseInt(getParameter(request, "width"), 200);
        int height = Utils.parseInt(getParameter(request, "height"), 200);
        */
        int width= 235;
        int height = 235;
		
        
        
		String string = getImgBase64(content, width, height);
		result.setValue(string);
	    String json = JSONUtil.bean2json(result);
	    response.getWriter().write(json);
	}
	
	
	public String getImgBase64 (String content,int width, int height){
		StringBuffer sb = new StringBuffer();
		sb.append("data:image/png;base64,");
		
		 try {
	            Qrcode qrcode=new Qrcode();

	            qrcode.setQrcodeErrorCorrect('M');
	            qrcode.setQrcodeEncodeMode('B');
	            qrcode.setQrcodeVersion(15);
	            BufferedImage image=new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
	            Graphics2D g2=image.createGraphics();
	            g2.setBackground(Color.WHITE);
	            g2.clearRect(0,0,235,235);
	            g2.setColor(Color.BLACK);

	            byte[] contentbytes=content.getBytes("utf-8");
	            boolean[][] codeout= qrcode.calQrcode(contentbytes);
	            for (int i = 0; i <codeout.length; i++) {
	                for (int j = 0; j < codeout.length; j++) {

	                    if (codeout[j][i]) g2.fillRect(j*3+2,i*3+2,3,3);
	                }
	            }
	            g2.dispose();
	            image.flush();
	           /* File imgFile = new File("D:\\1.jpg");
	            ImageIO.write(image, "png", imgFile);*/
	            
	            
	            ByteArrayOutputStream baos = new ByteArrayOutputStream();
	            ImageIO.write(image, "png", baos);
	            String data = DatatypeConverter.printBase64Binary(baos.toByteArray());
	            sb.append(data);
	            
	            
	        }catch (Exception e){
	            e.printStackTrace();
	        }
		 
		 return sb.toString();
	}
	
	public void drawQRCODE(String content,String filepath,int width,int height){
		try {
            Qrcode qrcode=new Qrcode();

            qrcode.setQrcodeErrorCorrect('M');
            qrcode.setQrcodeEncodeMode('B');
            qrcode.setQrcodeVersion(15);
            BufferedImage image=new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);
            Graphics2D g2=image.createGraphics();
            g2.setBackground(Color.WHITE);
            g2.clearRect(0,0,235,235);
            g2.setColor(Color.BLACK);

            byte[] contentbytes=content.getBytes("utf-8");
            boolean[][] codeout= qrcode.calQrcode(contentbytes);
            for (int i = 0; i <codeout.length; i++) {
                for (int j = 0; j < codeout.length; j++) {

                    if (codeout[j][i]) g2.fillRect(j*3+2,i*3+2,3,3);
                }
            }
            g2.dispose();
            image.flush();
            File imgFile = new File(filepath);
            ImageIO.write(image, "png", imgFile);
        }catch (Exception e){
            e.printStackTrace();
        }
	}
	
	/*public static void encoderQRCoder(String content, HttpServletResponse response) 
	{  
        try {  
            Qrcode handler = new Qrcode();  
            handler.setQrcodeErrorCorrect('M');  
            handler.setQrcodeEncodeMode('B');  
            handler.setQrcodeVersion(7);  
              
            System.out.println(content);  
            byte[] contentBytes = content.getBytes("UTF-8");  
              
            BufferedImage bufImg = new BufferedImage(80, 80, BufferedImage.TYPE_INT_RGB);  
              
            Graphics2D gs = bufImg.createGraphics();  
              
            gs.setBackground(Color.WHITE);  
            gs.clearRect(0, 0, 140, 140);  
              
            //设定图像颜色：BLACK  
            gs.setColor(Color.BLACK);  
              
            //设置偏移量  不设置肯能导致解析出错  
            int pixoff = 2;  
            //输出内容：二维码  
            if(contentBytes.length > 0 && contentBytes.length < 124) 
            {  
                boolean[][] codeOut = handler.calQrcode(contentBytes);  
                for(int i = 0; i < codeOut.length; i++) {  
                    for(int j = 0; j < codeOut.length; j++) {  
                        if(codeOut[j][i]) {  
                            gs.fillRect(j * 3 + pixoff, i * 3 + pixoff,3, 3);  
                        }  
                    }  
                }  
            } else {  
                System.err.println("QRCode content bytes length = " + contentBytes.length + " not in [ 0,120 ]. ");  
            }  
              
            gs.dispose();  
            bufImg.flush();  
              
            //生成二维码QRCode图片  
//            ImageIO.write(bufImg, "jpg", response.getOutputStream());  
            
            ByteArrayOutputStream baos = new ByteArrayOutputStream();

            
            ImageIO.write(bufImg, "png", baos);
            
            

            String data = DatatypeConverter.printBase64Binary(baos.toByteArray());
            System.out.println(data);
              
              
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  */
	
	/*public static void main(String[] args) throws Exception {
        int size = 200;
        BufferedImage image = new BufferedImage(
                size, size, BufferedImage.TYPE_INT_ARGB);

        Graphics2D g = image.createGraphics();
        g.setRenderingHint(
                RenderingHints.KEY_ANTIALIASING,
                RenderingHints.VALUE_ANTIALIAS_ON);
        g.setColor(Color.BLUE);
        for (int i = 0; i < size; i += 5) {
            g.drawOval(i, i, size - i, size - i);
        }
        g.dispose();
        
        

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(image, "png", baos);
        ImageIO.write(im, formatName, output)

        String data = DatatypeConverter.printBase64Binary(baos.toByteArray());
        String imageString = "data:image/png;base64," + data;
        String html = "<html><body><img src='" + imageString + "'></body></html>";
        System.out.println(html);
    }*/
}
