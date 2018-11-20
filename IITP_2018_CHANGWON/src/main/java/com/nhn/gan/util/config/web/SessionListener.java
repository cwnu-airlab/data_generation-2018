package com.nhn.gan.util.config.web;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionListener implements HttpSessionListener {

	private static long sessionActive;

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		sessionActive++;
		System.out.println("Session created");
		System.out.println("Session Active Session : " + sessionActive);
		se.getSession().setMaxInactiveInterval(15 * 60);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		sessionActive--;
		System.out.println("Session destroyed");
		System.out.println("Session Active Session : " + sessionActive);
	}

	public static long getSessionActive() {
		return sessionActive;
	}

}
