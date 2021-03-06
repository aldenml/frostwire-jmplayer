/*
 * Created by Erich Pleny (erichpleny)
 * Copyright (c) 2012, FrostWire(R). All rights reserved.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "JNIInterface.h"
#import <AppKit/AppKit.h>

jint GetJNIEnv(JavaVM* jvm, JNIEnv **env, bool *mustDetach);


JNIInterface::JNIInterface()
{
    env = NULL;
    owner = NULL;
    initialized = false;
}

JNIInterface::~JNIInterface()
{

}

JNIInterface& JNIInterface::GetInstance()
{
    static JNIInterface INSTANCE;
    return INSTANCE;
}




bool JNIInterface::Initialize(JNIEnv *env, jobject owner)
{
    if ( initialized )
    {
        return true;
    }
    
    this->env = env;
    this->owner = owner;
    
    // initialize the class object & method ids
    cls = env->GetObjectClass(owner);
    
    if (cls == 0)
    {
        printf("ERROR: unable to locate class MPlayerJNIHandler");
        return false;
    }
        
    changeVolumeID = env->GetMethodID(cls, "onVolumeChanged", "(F)V");
    if(changeVolumeID == 0 )
    {
        printf("ERROR: JNIInterface::Initialize() unable to get method id for onVolumeChanged");
        return false;
    }
    
    volumeIncrementID = env->GetMethodID(cls, "onIncrementVolumePressed", "()V");
    if(volumeIncrementID == 0 )
    {
        printf("ERROR: JNIInterface::Initialize() unable to get method id for onIncrementVolumePressed");
        return false;
    }
    
    volumeDecrementID = env->GetMethodID(cls, "onDecrementVolumePressed", "()V");
    if(volumeDecrementID == 0 )
    {
        printf("ERROR: JNIInterface::Initialize() unable to get method id for onDecrementVolumePressed");
        return false;
    }
        
    seekToTimeID = env->GetMethodID(cls, "onSeekToTime", "(F)V");
    if(seekToTimeID == 0 )
    {
        printf("ERROR: JNIInterface::Initialize() unable to get method id for onSeekToTime");
        return false;
    }
        
    playPressedID = env->GetMethodID(cls, "onPlayPressed", "()V");
    if(playPressedID == 0 )
    {
        printf("ERROR: JNIInterface::Initialize() unable to get method id for onPlayPressed");
        return false;
    }
        
    pausePressedID = env->GetMethodID(cls, "onPausePressed", "()V");
    if(pausePressedID == 0 )
    {
        printf("ERROR: JNIInterface::Initialize() unable to get method id for onPausePressed");
        return false;
    }
        
    fastForwardPressedID = env->GetMethodID(cls, "onFastForwardPressed", "()V");
    if(fastForwardPressedID == 0 )
    {
        printf("ERROR: JNIInterface::Initialize() unable to get method id for onFastForwardPressed");
        return false;
    }
        
    rewindPressedID = env->GetMethodID(cls, "onRewindPressed", "()V");
    if(rewindPressedID == 0 )
    {
        printf("ERROR: JNIInterface::Initialize() unable to get method id for onRewindPressed");
        return false;
    }
        
    toggleFullscreenPressedID = env->GetMethodID(cls, "onToggleFullscreenPressed", "()V");
    if(toggleFullscreenPressedID == 0 )
    {
        printf("ERROR: JNIInterface::Initialize() unable to get method id for onToggleFullscreenPressed");
        return false;
    }
    
    progressSliderStartedID = env->GetMethodID(cls, "onProgressSliderStarted", "()V");
    if(progressSliderStartedID == 0 )
    {
        printf("ERROR: JNIInterface::Initialize() unable to get method id for onProgressSliderStarted");
        return false;
    }
   
    progressSliderEndedID = env->GetMethodID(cls, "onProgressSliderEnded", "()V");
    if(progressSliderEndedID == 0 )
    {
        printf("ERROR: JNIInterface::Initialize() unable to get method id for onProgressSliderEnded");
        return false;
    }

    initialized = true;
    return true;
}

int JNIInterface::getJNIIntValue(jobject integerObject) {
    
    jclass cls = env->FindClass("java/lang/Integer");
    
    if(cls == NULL){
        return 0;
    }
    
    jmethodID getVal = env->GetMethodID(cls, "intValue", "()I");
    if(getVal == NULL){
        return 0;
    }
    
    int i = env->CallIntMethod(integerObject, getVal);
    return i;
}

float JNIInterface::getJNIFloatValue(jobject floatObject) {
    
    jclass cls = env->FindClass("java/lang/Float");
    
    if(cls == NULL){
        return 0;
    }
    
    jmethodID getVal = env->GetMethodID(cls, "floatValue", "()F");
    if(getVal == NULL){
        return 0;
    }
    
    float f = env->CallFloatMethod(floatObject, getVal);
    return f;
}

void JNIInterface::OnVolumeChanged(float volume)
{
    if (initialized) {
        env->CallVoidMethod(owner, changeVolumeID, volume);
    }
}

void JNIInterface::OnIncrementVolumePressed()
{
    if (initialized) {
        env->CallVoidMethod(owner, volumeIncrementID);
    }
}

void JNIInterface::OnDecrementVolumePressed()
{
    if (initialized) {
        env->CallVoidMethod(owner, volumeDecrementID);
    }
}

void JNIInterface::OnSeekToTime(float seconds)
{
    if (initialized) {
        env->CallVoidMethod(owner, seekToTimeID, seconds);
    }
}

void JNIInterface::OnPlayPressed()
{
    if (initialized) {
        env->CallVoidMethod(owner, playPressedID);
    }
}

void JNIInterface::OnPausePressed()
{
    if (initialized) {
        env->CallVoidMethod(owner, pausePressedID);
    }
}

void JNIInterface::OnFastForwardPressed()
{
    if (initialized) {
        env->CallVoidMethod(owner, fastForwardPressedID);
    }
}

void JNIInterface::OnRewindPressed()
{
    if (initialized) {
        env->CallVoidMethod(owner, rewindPressedID);
    }
}

void JNIInterface::OnToggleFullscreenPressed()
{
    if (initialized) {
        env->CallVoidMethod(owner, toggleFullscreenPressedID);
    }
}

void JNIInterface::OnProgressSliderStarted()
{
    if (initialized) {
        env->CallVoidMethod(owner, progressSliderStartedID);
    }
}

void JNIInterface::OnProgressSliderEnded()
{
    if (initialized) {
        env->CallVoidMethod(owner, progressSliderEndedID);
    }
}

jint GetJNIEnv(JavaVM* jvm, JNIEnv **env, bool *mustDetach) {
    jint getEnvErr = JNI_OK;
    *mustDetach = false;
    if (jvm) {
        getEnvErr = jvm->GetEnv((void **)env, JNI_VERSION_1_4);
        if (getEnvErr == JNI_EDETACHED) {
            getEnvErr = jvm->AttachCurrentThread((void **)env, NULL);
            if (getEnvErr == JNI_OK) {
                *mustDetach = true;
            }
        }
    }
    return getEnvErr;
}
