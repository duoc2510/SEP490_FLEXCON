package config;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggerInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(LoggerInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        logger.info("➡ [YÊU CẦU] {} {} | IP: {}", request.getMethod(), request.getRequestURI(), request.getRemoteAddr());
        request.setAttribute("startTime", System.currentTimeMillis());
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        long startTime = (long) request.getAttribute("startTime");
        long duration = System.currentTimeMillis() - startTime;

        if (duration > 1000) {
            logger.warn("⬅ [PHẢN HỒI CHẬM] {} {} | Trạng thái: {} | Thời gian: {} ms", request.getMethod(), request.getRequestURI(), response.getStatus(), duration);
        } else {
            logger.info("⬅ [PHẢN HỒI] {} {} | Trạng thái: {} | Thời gian: {} ms", request.getMethod(), request.getRequestURI(), response.getStatus(), duration);
        }

        if (ex != null) {
            logger.error("❌ [LỖI] Khi xử lý request: {} {}", request.getMethod(), request.getRequestURI(), ex);
        }
    }
}
